class Type < ActiveRecord::Base
  has_many :assessments
  
  validates :name, presence: true
  validates :weight, presence: true


  def to_param 
    name.gsub(' ', '-')
  end
end
