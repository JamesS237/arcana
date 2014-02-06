class Student < ActiveRecord::Base
  searchkick
  has_many :results
  has_many :averages

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  has_secure_password
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/ }, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :house, presence: true


  #ACCESSOR METHODS
  def full_name
    [first_name, last_name].join(' ')
  end

  def full_name=(name)
    split = name.split(' ', 2)
    self.first_name = split.first
    self.last_name = split.last
  end

  def house_name
    Student.houses[house]
  end

  def to_param
    id
  end

  def subject_average(subject)
    result = $redis.zscore("results:#{subject.redis_name}", self.id)
    if result == nil
      nil
    else
      result / subject.results.count
    end
  end

  def subject_rank(subject)
    $redis.zrank("results:#{subject.redis_name}", self.id)
  end

  def clear_averages!
    $redis.zrem("results:overall", self.id)
    $redis.zrem("results:overall:s1", self.id)
    $redis.zrem("results:overall:s2", self.id)

    $redis.zrem("results:exam:s1", self.id)
    $redis.zrem("results:exam:s2", self.id)
    $redis.zrem("results:exam", self.id)

    $redis.zrem("results:assessment:t1", self.id)
    $redis.zrem("results:assessment:t2", self.id)
    $redis.zrem("results:assessment:t3", self.id)
    $redis.zrem("results:assessment:t4", self.id)
    $redis.zrem("results:assessment:s1", self.id)
    $redis.zrem("results:assessment:s2", self.id)
    $redis.zrem("results:assessment", self.id)

    Subject.all.each do |subj|
      $redis.zrem("results:#{subj.redis_name}", self.id)
    end
  end

  def init_averages!
    $redis.zadd("results:overall", 0, self.id)
    $redis.zadd("results:overall:s1", 0, self.id)
    $redis.zadd("results:overall:s2", 0, self.id)

    $redis.zadd("results:exam:s1", 0, self.id)
    $redis.zadd("results:exam:s2", 0, self.id)
    $redis.zadd("results:exam", 0, self.id)

    $redis.zadd("results:assessment:t1", 0, self.id)
    $redis.zadd("results:assessment:t2", 0, self.id)
    $redis.zadd("results:assessment:t3", 0, self.id)
    $redis.zadd("results:assessment:t4", 0, self.id)
    $redis.zadd("results:assessment:s1", 0, self.id)
    $redis.zadd("results:assessment:s2", 0, self.id)
    $redis.zadd("results:assessment", 0, self.id)

    Subject.all.each do |subj|
      $redis.zadd("results:#{subj.redis_name}", 0, self.id)
    end
  end

  def recalculate_averages!
    self.clear_averages!
    self.init_averages!
    self.results.each do |r|
      r.update_averages!
    end
  end

  def Student.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Student.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def benchmark_recalculate_averages!
    require "benchmark"
    time = Benchmark.measure do
      self.recalculate_averages!
    end
    return "Time elapsed #{time*1000} milliseconds"
  end

  def exams(period)
    $redis.lrange("info:exams:list:#{period}")
  end

  def assessments(period)
    $redis.lrange("info:assessments:list:#{period}")
  end

  def overall_average
    return {
      :exams => {
        :s1 => {
          :average => $redis.zscore("results:exam:s1", self.id) / self.exams('s2').count,
          :rank => $redis.zrank("results:exam:s1", self.id)
        }, :s2 => {
          :average => $redis.zscore("results:exam:s1", self.id) / self.exams('s1').count,
          :rank => $redis.zrank("results:exam:s1", self.id)
        }, :overall => {
          :average => $redis.zscore("results:exam", self.id) / self.exams('all').count,
          :rank => $redis.zrank("results:exam", self.id)
        }
      }, :assessment => {
        :s1 => {
          :average => $redis.zscore("results:assessment:s1", self.id) / self.assessments('s1').count,
          :rank => $redis.zrank("results:assessment:s1", self.id)
        }, :s2 => {
          :average => $redis.zscore("results:assessment:s1", self.id) / self.assessments('s2').count,
          :rank => $redis.zrank("results:assessment:s1", self.id)
        }, :t1 => {
          :average => $redis.zscore("results:assessment:t1", self.id) / self.assessments('t1').count,
          :rank => $redis.zrank("results:assessment:t1", self.id)
        }, :t2 => {
          :average => $redis.zscore("results:assessment:t2", self.id) / self.assessments('t2').count,
          :rank => $redis.zrank("results:assessment:t2", self.id)
        }, :t3 => {
          :average => $redis.zscore("results:assessment:t3", self.id) / self.assessments('t3').count,
          :rank => $redis.zrank("results:assessment:t3", self.id)
        }, :t4 => {
          :average => $redis.zscore("results:assessment:t4", self.id) / self.assessments('t4').count,
          :rank => $redis.zrank("results:assessment:t4", self.id)
        },:overall => {
          :average => $redis.zscore("results:assessment", self.id) / self.assessments('all').count,
          :rank => $redis.zrank("results:assessment", self.id)
        }
      }, :overall => {
        :s1 => {
          :average => $redis.zscore("results:overall:s1", self.id) / self.results.count,
          :rank => $redis.zrank("results:overall:s1", self.id)
        }, :s2 => {
          :average => $redis.zscore("results:overall:s2", self.id) / self.results.count,
          :rank => $redis.zrank("results:overall:s2", self.id)
        }, :overall => {
          :average => $redis.zscore("results:overall", self.id) / self.results.count,
          :rank => $redis.zrank("results:overall", self.id)
        }
      }
    }
  end

  def self.houses
    houses = {0 => "Select a House", 1 => "Aherne", 2 => "Frew", 3 => "Jenkin", 4 => "Jones", 5 => "Millward", 6 => "Riley"}
  end

  def class_group_letter
    letters = { 1 => "c", 2 => "d", 3 => "h", 4 => "m", 5 => "v", 6 => "w"}
    letters[self.class_group]
  end

  def self.class_groups
    class_groups = {0 => "Select Class", 1 => "9C", 2 => "9D", 3 => "9H", 4 => "9M", 5 => "9V", 6 => "9W"}
  end

  private
    def create_remember_token
      self.remember_token = Student.encrypt(Student.new_remember_token)
    end
end
