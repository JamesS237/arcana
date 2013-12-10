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
    case self.subject.name
    when "History"
      case student.house_name
      when "Aherne"
        return self.term
      when "Frew"
        return self.term + 2
      when "Jenkin"
        return self.term
      when "Jones"
        return self.term + 2
      when "Millward"
        return self.term
      when "Riley"
        return self.term + 2
    when "Geography"
      case student.house_name
      when "Aherne"
        return self.term + 2
      when "Frew"
        return self.term 
      when "Jenkin"
        return self.term + 2 
      when "Jones"
        return self.term 
      when "Millward"
        return self.term + 2
      when "Riley"
        return self.term 
    when "Music"
      case student.house_name
      when "Aherne"
        return self.term + 2
      when "Frew"
        return self.term + 2
      when "Jenkin"
        return self.term + 2
      when "Jones"
        return self.term 
      when "Millward"
        return self.term 
      when "Riley"
        return self.term
    when "Art"
      case student.house_name
      when "Aherne"
        return self.term
      when "Frew"
        return self.term 
      when "Jenkin"
        return self.term
      when "Jones"
        return self.term + 2
      when "Millward"
        return self.term + 2
      when "Riley"
        return self.term + 2
    when "Religious Education"
      case student.house_name
      when "Aherne"
        return self.term + 2
      when "Frew"
        return self.term + 2
      when "Jenkin"
        return self.term + 2
      when "Jones"
        return self.term 
      when "Millward"
        return self.term
      when "Riley"
        return self.term 
    when "Personal Development"
      case student.house_name
      when "Aherne"
        return self.term
      when "Frew"
        return self.term 
      when "Jenkin"
        return self.term
      when "Jones"
        return self.term + 2
      when "Millward"
        return self.term + 2
      when "Riley"
        return self.term + 2
  end
end
