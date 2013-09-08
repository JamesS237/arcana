class Subject < ActiveRecord::Base
  has_many :assessments
  
  def leader 
    leader = Student.all.sort { |a,b| a.average(self) <=> b.average(self) }.first
  end
  
  def to_param
    self.name.gsub(' ', '-')
  end
end


