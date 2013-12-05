class Subject < ActiveRecord::Base
  has_many :assessments
  
  validates :name, presence: true

  def leader 
    avgs = []
    Student.all.each do |s|
      if(s.average(self) != nil)
        avgs.push({"id" => s.id, "average" => s.average(self)})
      end
    end
    leader_id = avgs.sort_by!{|avg| avg["average"] }.last["id"]
    Student.find(leader_id);
  end
  
  def to_param
    self.name.gsub(' ', '-')
  end
end


