class Type < ActiveRecord::Base
  has_many :assessments

  def to_param 
    name.gsub(' ', '-')
  end
end
