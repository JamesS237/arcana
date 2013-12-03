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
    houses = {0 => "Please Select a House", 1 => "Aherne", 2 => "Frew", 3 => "Jenkin", 4 => "Jones", 5 => "Millward", 6 => "Riley"}
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
  
  def average(subject)
    
    self.results.where("assessment_id IN(SELECT id FROM assessments WHERE subject_id = ?)", subject.id).average("mark")
  end

  def averages
    subjects = Hash.new
    Subject.each do |subject| 
     average = {
        :s1 => { :t1, :t2, :exam, :assessment, :overall }, 
        :s2 => { :t3, :t4, :exam, :assessment, :overall }, 
        :year => { :assessment, :exam, :overall } 
      }
      average[:s1][:t1] = self.t1.results.where(:subject_id => subject.id)
      average[:s1][:t2] = self.t2.results.where(:subject_id => subject.id)
      average[:s2][:t3] = self.t3.results.where(:subject_id => subject.id)
      average[:s2][:t4] = self.t4.results.where(:subject_id => subject.id)
      exam_query = 'results.assessment_id 
                    IN(SELECT assessments.id 
                    FROM assessments 
                    WHERE assessments.type_in 
                    IN(SELECT types.id FROM types WHERE types.name = "Exam"))'
      average[:s2][:exam] =  self.t2.results.where(:subject_id => subject.id).where(exam_query)

      subjects[subject.name.downcase.to_sym] = average
    end
    averages = {
                :total => 
                {
                  :s1 => { :t1, :t2, :exam, :assessment, :overall }, 
                  :s2 => { :t3, :t4, :exam, :assessment, :overall }, 
                  :year => { :assessment, :exam, :overall }, 
                }

                :subjects => subjects
              }
  end

  private

    def create_remember_token
      self.remember_token = Student.encrypt(Student.new_remember_token)
    end
end
