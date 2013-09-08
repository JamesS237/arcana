class Assessment < ActiveRecord::Base
  has_many :results
  belongs_to :type
  belongs_to :subject
  
  def to_param 
    title.gsub(' ', '-')
  end
end
