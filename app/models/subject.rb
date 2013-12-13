class Subject < ActiveRecord::Base
  has_many :assessments
  
  validates :name, presence: true

  def leader 
    avgs = []
    Average.where(:subject_id => self.id).each do |avg| 
      avgs.push({"id" => .student_id, "average" => avg.overall})
    end
    leader_id = avgs.sort_by!{|avg| avg["average"] }.last["id"]
    Student.find(leader_id);
  end
  
  def to_param
    self.name.gsub(' ', '-')
  end
end


