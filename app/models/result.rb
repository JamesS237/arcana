class Result < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :student

  after_save :update_averages!
  after_save :set_term!

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
  	case self.assessment.subject.name
    when "History"
      case self.student.class_group
      when "c"
        self.term = self.assessment.term + 2
      when "m"
        self.term = self.assessment.term
      when "d"
        self.term = self.assessment.term + 2
      when "v"
        self.term = self.assessment.term
      when "w"
        self.term = self.assessment.term + 2
      when "h"
        self.term = self.assessment.term
      end
    when "Geography"
      case self.student.class_group
      when "c"
        self.term = self.assessment.term
      when "m"
        self.term = self.assessment.term + 2
      when "v"
        self.term = self.assessment.term
      when "w"
        self.term = self.assessment.term + 2
      when "d"
        self.term = self.assessment.term
      when "h"
        self.term = self.assessment.term + 2
      end
    #RE: v h c
    #Drama: w m d
    when "Religious Education"
      case self.student.class_group
      when "h"
        self.term = self.assessment.term
      when "v"
        self.term = self.assessment.term
      when "w"
        self.term = self.assessment.term + 2
      when "d"
        self.term = self.assessment.term + 2
      when "m"
        self.term = self.assessment.term + 2
      when "c"
        self.term = self.assessment.term
      end
    when "Personal Development"
      case self.student.class_group
      when "h"
        self.term = self.assessment.term + 2
      when "v"
        self.term = self.assessment.term + 2
      when "w"
        self.term = self.assessment.term
      when "d"
        self.term = self.assessment.term
      when "m"
        self.term = self.assessment.term
      when "c"
        self.term = self.assessment.term + 2
      end
    else
      self.term = self.assessment.term
    end
  end

  def update_averages!
    $redis.zadd("results:#{self.subject.redis_name}", self.mark, self.first_name.downcase)
    if(self.exam && self.term <= 2)
      $redis.zadd("results:exam:s1", self.mark, self.first_name.downcase)
    elsif(self.exam && self.term > 2)
      $redis.zadd("results:exam:s2", self.mark, self.first_name.downcase)
    else
      $redis.zadd("results:assessment", self.mark, self.first_name.downcase)
    end
  end
end



