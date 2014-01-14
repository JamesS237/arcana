class Result < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :student
  
  validates :student_id, presence: true
  validates :mark, presence: true
  validates :assessment_id, presence: true

    def set_term
    	case self.assessment.subject.name
      when "History"
        #c m d v w h
        case self.student.class_group
        when "c"
          self.term = self.assessment.term + 2
        when "m"
          self.term = self.assessment.term + 2
        when "d"
          self.term = self.assessment.term
        when "v"
          self.term = self.assessment.term + 2
        when "w"
          self.term = self.assessment.term
        when "h"
          self.term = self.assessment.term + 2
        end
      when "Geography"
        case self.student.class_group
        when "c"
          self.term = self.assessment.term + 2
        when "m"
          self.term = self.assessment.term
        when "v"
          self.term = self.assessment.term + 2
        when "w"
          self.term = self.assessment.term
        when "d"
          self.term = self.assessment.term + 2
        when "h"
          self.term = self.assessment.term
        end
      when "Music"
        case self.student.class_group
        when "h"
          self.term = self.assessment.term + 2
        when "v"
          self.term = self.assessment.term + 2
        when "w"
          self.term = self.assessment.term + 2
        when "d"
          self.term = self.assessment.term
        when "m"
          self.term = self.assessment.term
        when "c"
          self.term = self.assessment.term
        end
      when "Art"
        case self.student.class_group
        when "h"
          self.term = self.assessment.term 
        when "v"
          self.term = self.assessment.term
        when "w"
          self.term = self.assessment.term 
        when "d"
          self.term = self.assessment.term + 2
        when "m"
          self.term = self.assessment.term + 2
        when "c"
          self.term = self.assessment.term + 2
        end
      when "Religious Education"
        case self.student.class_group
        when "h"
          self.term = self.assessment.term + 2
        when "v"
          self.term = self.assessment.term + 2
        when "w"
          self.term = self.assessment.term + 2
        when "d"
          self.term = self.assessment.term
        when "m"
          self.term = self.assessment.term 
        when "c"
          self.term = self.assessment.term
        end
      when "Personal Development"
        case self.student.class_group
        when "h"
          self.term = self.assessment.term 
        when "v"
          self.term = self.assessment.term
        when "w"
          self.term = self.assessment.term 
        when "d"
          self.term = self.assessment.term + 2
        when "m"
          self.term = self.assessment.term + 2
        when "c"
          self.term = self.assessment.term + 2
        end
      else 
        self.term = self.assessment.term
      end
    end
  end
end



