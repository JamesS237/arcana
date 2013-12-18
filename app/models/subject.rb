class Subject < ActiveRecord::Base
  has_many :assessments
  has_many :averages
  
  validates :name, presence: true

  def leader 
    avgs = []
    Average.where(:subject_id => self.id).each do |avg| 
      avgs.push({"id" => avg.student_id, "average" => avg.overall})
    end
    leader_id = avgs.sort_by!{|avg| avg["average"] }.last["id"]
    Student.find(leader_id);
  end

  def mean_average
    overalls = []
    puts Average.where(:subject_id => self.id).each.inspect
    Average.where(:subject_id => self.id).each do |a|
      puts "AVERAGE: #{a.overall}"
      overalls << a.overall
    end
    total = 0
    count = 0
    overalls.each do |val|  
      next unless val != 0 && val != nil
      count += 1
      total += val
    end
    return (total / count).round(2)
  end
  
  def to_param
    self.name.gsub(' ', '-')
  end
end


