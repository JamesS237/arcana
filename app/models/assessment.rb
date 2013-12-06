class Assessment < ActiveRecord::Base
  has_many :results
  belongs_to :type
  belongs_to :subject
  validates :title, presence: true
  validates :subject_id, presence: true
  validates :type_id, presence: true
  
  def to_param 
    title.gsub(' ', '-')
  end
  
  def self.uncomplete(student)
    complete = Result.find_all_by_student_id(student.id)
    if (complete == [])
      return Assessment.all
    end
    Assessment.find(:all, :conditions => ['id not in (?)', complete.map(&:assessment_id)])
  end

  def real_term(student)
    if(self.subject.name in ["History", "Geogrpahy", "RE", "Drama"])
      #0: C, 1: D, 2: H, 3: M, 4: V, 5: W
      #History/Geogrpahy
      #Drama/RE
      if(student.class_group in [0, 1, 2]) #History: V, H (c?), Geography: 
        if self.term == 1 or self.term == 2
          return self.term + 2
        else
          return self.term
        end
      end
    else
      return self.term
    end
  end
end
