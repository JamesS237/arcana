class Student < ActiveRecord::Base
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
    normalized_name = full_name.gsub(' ', '-')
  end

  def subject_average(subject)
    $redis.zscore("results:#{subject.redis_name}", self.id) / subject.results.count
  end

  def clear_averages!
    $redis.zrem("results:exam:s1", self.id)
    $redis.zrem("results:exam:s2", self.id)

    $redis.zrem("results:assessment:t1", self.id)
    $redis.zrem("results:assessment:t2", self.id)
    $redis.zrem("results:assessment:t3", self.id)
    $redis.zrem("results:assessment:t4", self.id)

    Subject.all.each do |subj|
      $redis.zrem("results:#{subj.redis_name}", self.id)
    end
  end

  def recalculate_averages!
    self.clear_averages!
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

  def exams(period)
    results = self.results.where('assessment_id
        IN(
          SELECT assessments.id FROM assessments WHERE type_id
          IN(
            SELECT types.id FROM types WHERE name = "Exam"))')
    if(period == 'all')
      return results
    elsif(period == 's1')
      return results.where('term = 1 OR term = 2')
    elsif(period == 's2')
      return results.where('term = 3 OR term = 4')
    end
  end

  def overall_average
    return {
      :exams => {
        :s1 => {
          :average => $redis.zscore("results:exams:s1", self.id) / self.exams('s2').count,
          :rank => $redis.zrank("results:exams:s1", self.id)
        }, :s2 => {
          :average => $redis.zscore("results:exams:s1", self.id) / self.exams('s1').count,
          :rank => $redis.zrank("results:exams:s1", self.id)
        }, :overall => {
          :average => $redis.zscore("results:exams", self.id) / self.exams('all').count,
          :rank => $redis.zrank("results:exams", self.id)
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
          :average => $redis.zscore("results:assessment", self.id) / self.assessments('all').count,,
          :rank => $redis.zrank("results:assessment", self.id)
        }
      },
    }
  end

  def self.search(search)
    Student.all.where("first_name LIKE ? OR last_name LIKE ? OR first_name + ' ' + last_name LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def self.houses
    houses = {0 => "Select a House", 1 => "Aherne", 2 => "Frew", 3 => "Jenkin", 4 => "Jones", 5 => "Millward", 6 => "Riley"}
  end

  def self.class_groups
    class_groups = {0 => "Select Class", 1 => "9C", 2 => "9D", 3 => "9H", 4 => "9M", 5 => "9V", 6 => "9W"}
  end

  private
    def create_remember_token
      self.remember_token = Student.encrypt(Student.new_remember_token)
    end
end
