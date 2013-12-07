class Student < ActiveRecord::Base
  has_secure_password 
  has_many :results
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :house, presence: true
  
  #validates :password, length: { minimum: 6 }

  def self.houses
    houses = {0 => "Select a House", 1 => "Aherne", 2 => "Frew", 3 => "Jenkin", 4 => "Jones", 5 => "Millward", 6 => "Riley"}
  end

  def self.class_groups
    class_groups = {0 => "Select Class", 1 => "9C", 2 => "9D", 3 => "9H", 4 => "9M", 5 => "9V", 6 => "9W"}
  end

  
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
  
  def Student.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Student.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def to_param
    normalized_name = full_name.gsub(' ', '-')
  end
  
  def subject_average(subject)
    self.results.where("assessment_id IN(SELECT id FROM assessments WHERE subject_id = ?)", subject.id).average("mark")
  end

  def get_term_results(term)
    result_ids = []
    Result.where(:student_id => self.id).each do |r|
      if r.assessment.real_term(self) == term
        result_ids << r.id
      end
    end
    return Result.where('id IN(?)', result_ids)
  end

  def t1
    return { :results => get_term_results(1) }
  end

  def t2
    return { 
      :results => get_term_results(2), 
      :exams =>  get_term_results(2).where("assessment_id IN 
                                            (SELECT assessments.id FROM assessments WHERE assessments.type_id IN 
                                            (SELECT types.id FROM types WHERE types.name = 'Exam'))")}
  end

  def t3
    return { 
      :results => get_term_results(2), 
      :exams =>  get_term_results(3).where("assessment_id IN 
                                            (SELECT assessments.id FROM assessments WHERE assessments.type_id IN 
                                            (SELECT types.id FROM types WHERE types.name = 'Exam'))")}
  end

  def t4
    return { 
      :results => get_term_results(4), 
      :exams =>  get_term_results(4).where("assessment_id IN 
                                            (SELECT assessments.id FROM assessments WHERE assessments.type_id IN 
                                            (SELECT types.id FROM types WHERE types.name = 'Exam'))") }
  end
  
  def averages
    average = 
    {
      :total => 
      {
        :s1 => { 
                  :t1 => 0, 
                  :t2 => 0, 
                  :exam => 0, 
                  :assessment => 0, 
                  :overall => 0
                }, 
        :s2 => { 
                  :t1 => 0, 
                  :t2 => 0, 
                  :exam => 0, 
                  :assessment => 0, 
                  :overall => 0
                }, 
        :year => { 
                  :exam => 0, 
                  :assessment => 0, 
                  :overall => 0
                  }, 
      },

      :subjects => {}
    }

    average[:total][:s1][:t1]           = self.t1[:results].average('mark') || 1
    average[:total][:s1][:t2]           = self.t2[:results].average('mark') || 1
    average[:total][:s2][:t3]           = self.t3[:results].average('mark') || 1
    average[:total][:s2][:t4]           = self.t4[:results].average('mark') || 1
    average[:total][:s1][:exam]         = self.t2[:exams].average('mark')   || 1
    average[:total][:s2][:exam]         = self.t4[:exams].average('mark')   || 1

    average[:total][:s1][:assessment]   =  ((average[:total][:s1][:t1] + average[:total][:s1][:t2]) / 2).round(2)
    average[:total][:s2][:assessment]   =  ((average[:total][:s2][:t3] + average[:total][:s2][:t4]) / 2).round(2)
    average[:total][:s1][:overall]      =  ((average[:total][:s1][:exam] + average[:total][:s1][:assessment]) / 2).round(2)
    average[:total][:s2][:overall]      =  ((average[:total][:s2][:exam] + average[:total][:s2][:assessment]) / 2).round(2)
    average[:total][:year][:assessment] =  ((average[:total][:s1][:assessment] + average[:total][:s2][:assessment]) / 2).round(2)
    average[:total][:year][:exam]       =  ((average[:total][:s1][:exam] + average[:total][:s2][:exam]) / 2).round(2)
    average[:total][:year][:overall]    =  ((average[:total][:s1][:overall] + average[:total][:s2][:overall]) / 2).round(2)

    subjects = Hash.new

    Subject.all.each do |subject|
      average = 
      {
        :s1 => { 
                  :t1 => 0, 
                  :t2 => 0, 
                  :exam => 0, 
                  :assessment => 0, 
                  :overall => 0
                }, 
        :s2 => { 
                  :t1 => 0, 
                  :t2 => 0, 
                  :exam => 0, 
                  :assessment => 0, 
                  :overall => 0
                }, 
        :year => { 
                  :exam => 0, 
                  :assessment => 0, 
                  :overall => 0
                  }, 
      }

      subject_query = 'assessment_id IN(SELECT assessments.id FROM assessments WHERE assessments.subject_id = ?)'

      average[:s1][:t1]           = self.t1[:results].where(subject_query, subject.id).average('mark') || 1
      average[:s1][:t2]           = self.t2[:results].where(subject_query, subject.id).average('mark') || 1
      average[:s2][:t3]           = self.t3[:results].where(subject_query, subject.id).average('mark') || 1
      average[:s2][:t4]           = self.t4[:results].where(subject_query, subject.id).average('mark') || 1

      average[:s1][:exam]         =  self.t2[:exams].where(subject_query, subject.id).average('mark') || 1
      average[:s2][:exam]         =  self.t4[:exams].where(subject_query, subject.id).average('mark') || 1

      average[:s1][:assessment]   =  ((average[:s1][:t1] + average[:s1][:t2]) / 2).round(2)
      average[:s2][:assessment]   =  ((average[:s2][:t3] + average[:s2][:t4]) / 2).round(2)

      average[:s1][:overall]      =  ((average[:s1][:exam] + average[:s1][:assessment]) / 2).round(2)
      average[:s2][:overall]      =  ((average[:s2][:exam] + average[:s2][:assessment]) / 2).round(2)

      average[:year][:assessment] =  ((average[:s1][:assessment] + average[:s2][:assessment]) / 2).round(2)
      average[:year][:exam]       =  ((average[:s1][:exam] + average[:s2][:exam]) / 2).round(2)
      average[:year][:overall]    =  ((average[:s1][:overall] + average[:s2][:overall]) / 2).round(2)

      subjects[subject.name.downcase.to_sym] = average
    end
    return averages
  end

  private

    def create_remember_token
      self.remember_token = Student.encrypt(Student.new_remember_token)
    end
end
