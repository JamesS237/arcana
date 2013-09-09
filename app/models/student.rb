class Student < ActiveRecord::Base
  has_secure_password
  has_many :results
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  validates :password, length: { minimum: 6 }
  
  def self.houses
    houses = {0 => "Please Select a House", 1 => "Aherne", 2 => "Frew", 3 => "Jenkin", 4 => "Jones", 5 => "Millward", 6 => "Riley"}
  end
  
  def full_name
    self.first_name + " " + self.last_name
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
    marks = Array.new
    self.results.select{ |result| result.assessment.subject.id == subject.id }.each do |result|
      marks << result.mark 
      if(result.assessment.type.weight != 1)
        weight = result.assessment.type.weight
        while weight > 1
          marks << result.mark 
          weight -= 1
        end
      end
    end
    avg = marks.inject{ |sum, el| sum + el }.to_f / marks.size
    avg.round(2)
  end

  private

    def create_remember_token
      self.remember_token = Student.encrypt(Student.new_remember_token)
    end
end
