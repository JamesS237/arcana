class Result < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :student
  
  validates :student_id, presence: true
  validates :mark, presence: true
  validates :assessment_id, presence: true

  def set_term
  	case self.assessment.subject.name
    when "History"
      case self.student.house_name
      when "Aherne"
        self.term = self.assessment.term + 2
      when "Frew"
        self.term = self.assessment.term + 2
      when "Jenkin"
        self.term = self.assessment.term
      when "Jones"
        self.term = self.assessment.term + 2
      when "Millward"
        self.term = self.assessment.term
      when "Riley"
       	self.term = self.assessment.term + 2
      end
    when "Geography"
      case self.student.house_name
      when "Aherne"
        self.term = self.assessment.term + 2
      when "Frew"
        self.term = self.assessment.term
      when "Jenkin"
        self.term = self.assessment.term + 2
      when "Jones"
        self.term = self.assessment.term
      when "Millward"
        self.term = self.assessment.term + 2
      when "Riley"
        self.term = self.assessment.term
      end
    when "Music"
      case self.student.house_name
      when "Aherne"
        self.term = self.assessment.term + 2
      when "Frew"
        self.term = self.assessment.term + 2
      when "Jenkin"
        self.term = self.assessment.term + 2
      when "Jones"
        self.term = self.assessment.term
      when "Millward"
        self.term = self.assessment.term
      when "Riley"
        self.term = self.assessment.term
      end
    when "Art"
      case self.student.house_name
      when "Aherne"
        self.term = self.assessment.term 
      when "Frew"
        self.term = self.assessment.term
      when "Jenkin"
        self.term = self.assessment.term 
      when "Jones"
        self.term = self.assessment.term + 2
      when "Millward"
        self.term = self.assessment.term + 2
      when "Riley"
        self.term = self.assessment.term + 2
      end
    when "Religious Education"
      case self.student.house_name
      when "Aherne"
        self.term = self.assessment.term + 2
      when "Frew"
        self.term = self.assessment.term + 2
      when "Jenkin"
        self.term = self.assessment.term + 2
      when "Jones"
        self.term = self.assessment.term
      when "Millward"
        self.term = self.assessment.term 
      when "Riley"
        self.term = self.assessment.term
      end
    when "Personal Development"
      case self.student.house_name
      when "Aherne"
        self.term = self.assessment.term 
      when "Frew"
        self.term = self.assessment.term
      when "Jenkin"
        self.term = self.assessment.term 
      when "Jones"
        self.term = self.assessment.term + 2
      when "Millward"
        self.term = self.assessment.term + 2
      when "Riley"
        self.term = self.assessment.term + 2
      end
    else 
      self.term = self.assessment.term
    end
  end
end
