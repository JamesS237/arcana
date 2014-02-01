class Result < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :student

  after_save :set_term!
  after_save :update_averages!

  validates :student_id, presence: true
  validates :mark, presence: true
  validates :assessment_id, presence: true

  @term_data = {
    "History"   => { "c" => 2, "d" => 2, "h" => 0, "m" => 0, "v" => 0, "w" => 2 },
    "Geography" => { "c" => 0, "d" => 0, "h" => 2, "m" => 2, "v" => 0, "w" => 2 },
    "REPD"      => { "c" => 0, "d" => 2, "h" => 0, "m" => 2, "v" => 0, "w" => 2 },
    "Drama"     => { "c" => 2, "d" => 0, "h" => 2, "m" => 0, "v" => 2, "w" => 0 }
  }

  def set_term!
    self.term = self.assessment.term + @term_data[self.assessment.subject.name][self.student.class_group]
  end

  def semester
    if(self.term > 2)
      return 2
    else
      return 1
    end
  end

  def update_averages!
    $redis.zincrby("results:#{self.assessment.subject.redis_name}", self.mark, self.student.id)
    if(self.assessment.exam? && self.term <= 2)
      $redis.zincrby("results:exam:s1", self.mark, self.student.id)
      $redis.zincrby("results:exam", self.mark, self.student.id)
    elsif(self.assessment.exam? && self.term > 2)
      $redis.zincrby("results:exam:s2", self.mark, self.student.id)
      $redis.zincrby("results:exam", self.mark, self.student.id)
    else
      $redis.zincrby("results:assessment", self.mark, self.student.id)
      $redis.zincrby("results:assessment#{self.term.to_s}", self.mark, self.student.id)
      $redis.zincrby("results:assessment#{self.semester.to_s}", self.mark, self.student.id)
    end
  end
end



