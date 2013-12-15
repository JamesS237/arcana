class Student < ActiveRecord::Base
  has_many :results
  has_many :averages

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  has_secure_password
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :house, presence: true
  
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

  def update_averages(subject_id, term, exam)
    subject_query = 'assessment_id IN(SELECT assessments.id FROM assessments WHERE assessments.subject_id = ?)'

    exam_query = "assessment_id IN (SELECT assessments.id FROM assessments WHERE assessments.type_id IN 
                                   (SELECT types.id FROM types WHERE types.name = 'Exam'))"

    subject_average = self.averages.where(:subject_id, subject_id).first

    if(subject_average == nil)
      subject_average = Average.new
      subject_average.student_id = self.id
      subject_average.subject_id = subject_id
    end

    if(self.averages.where(:overall => true).empty?)
      overall_average = Average.new
      overall_average.student_id = self.id
      overall_average.overall = true
    else
      overall_average = self.averages.where(:overall => true).first
    end

    if(exam)
      subj_raw_avg = self.results.where(subject_query, subject_id).where(:term => term).where(exam_query).average("mark")
      overall_raw_avg = self.results.where(:term => term).where(exam_query).average("mark")
      if(term == 2)
        overall_average.exams_s1 = overall_raw_avg
        subject_average.exams_s1 = subj_raw_avg
      else
        overall_average.exams_s2 = overall_raw_avg
        subject_average.exams_s2 = subj_raw_avg
      end

    else
      subj_raw_avg = self.results.where(subject_query, subject_id).where(:term => term).average("mark")
      overall_raw_avg = self.results.where(:term => term).average("mark")
      case term
      when 1
        overall_average.t1 = overall_raw_avg
        subject_average.t1 = subj_raw_avg
      when 2
        overall_average.t2 = overall_raw_avg
        subject_average.t2 = subj_raw_avg
      when 3
        overall_average.t3 = overall_raw_avg
        subject_average.t3 = subj_raw_avg
      when 4
        overall_average.t4 = overall_raw_avg
        subject_average.t4 = subj_raw_avg
      end
    end
    subject_average.save
    overall_average.save
  end

  private

    def create_remember_token
      self.remember_token = Student.encrypt(Student.new_remember_token)
    end
end
