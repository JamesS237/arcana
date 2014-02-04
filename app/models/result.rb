class Result < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :student

  after_save :update_averages!

  validates :student_id, presence: true
  validates :mark, presence: true
  validates :assessment_id, presence: true

  def set_term!
    term_data = {
    "History"   => { "c" => 2, "d" => 2, "h" => 0, "m" => 0, "v" => 0, "w" => 2 },
    "Geography" => { "c" => 0, "d" => 0, "h" => 2, "m" => 2, "v" => 0, "w" => 2 },
    "REPD"      => { "c" => 0, "d" => 2, "h" => 0, "m" => 2, "v" => 0, "w" => 2 },
    "Drama"     => { "c" => 2, "d" => 0, "h" => 2, "m" => 0, "v" => 2, "w" => 0 }
    }
    if(term_data[self.assessment.subject.name] == nil)
      self.term = self.assessment.term
      return
    end

    self.term = self.assessment.term + term_data[self.assessment.subject.name][self.student.class_group_letter]
  end

  def semester
    if(self.term > 2)
      return 2
    else
      return 1
    end
  end

  def get_jsonable_hash
    hash = {}
    hash[:id] = self.id
    hash[:mark] = self.mark.to_i
    hash[:studentId] self.student_id
    hash[:studentName] = (self.student.first_name + ' ' + self.student.last_name)
    hash[:studentHouse] = self.student.house_name
    hash[:assessmentId] = self.assessment_id
    hash[:assessmentName] = self.assessment.title
    hash[:typeId] = self.assessment.type.id
    hash[:typeName] = self.assessment.type.name
    hash[:subjectId] = self.assessment.subject.id
    hash[:subjectName] = self.assessment.subject.name
    hash
  end

  def update_averages!
    $redis.zincrby("results:overall", self.mark, self.student.id)
    $redis.zincrby("results:overall:s#{self.semester.to_s}", self.mark, self.student.id)
    $redis.zincrby("results:#{self.assessment.subject.redis_name}", self.mark, self.student.id)
    if(self.assessment.exam? && self.term <= 2)
      $redis.zincrby("results:exam:s1", self.mark, self.student.id)
      $redis.zincrby("results:exam", self.mark, self.student.id)
    elsif(self.assessment.exam? && self.term > 2)
      $redis.zincrby("results:exam:s2", self.mark, self.student.id)
      $redis.zincrby("results:exam", self.mark, self.student.id)
    else
      $redis.zincrby("results:assessment", self.mark, self.student.id)
      $redis.zincrby("results:assessment:#{self.term.to_s}", self.mark, self.student.id)
      $redis.zincrby("results:assessment:#{self.semester.to_s}", self.mark, self.student.id)
    end
  end
end



