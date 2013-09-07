class Student < ActiveRecord::Base
  has_secure_password
  has_many :results
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  validates :password, length: { minimum: 6 }
  
  def self.houses
    houses = {1 => "Aherne", 2 => "Frew", 3 => "Jenkin", 4 => "Jones", 5 => "Millward", 6 => "Riley"}
  end
  
  def Student.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Student.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def to_param
    normalized_name = first_name + "-" + last_name
  end

  private

    def create_remember_token
      self.remember_token = Student.encrypt(Student.new_remember_token)
    end
end
