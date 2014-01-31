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

  def update_averages!
    $redis.zadd("results:#{self.subject.redis_name}:t#{self.term.to_s}", self.mark, self.first_name.downcase)
    if(self.exam && self.term <= 2)
      $redis.zadd("results:exam:s1", self.mark, self.first_name.downcase)
    elsif(self.exam && self.term > 2)
      $redis.zadd("results:exam:s2", self.mark, self.first_name.downcase)
    else
      $redis.zadd("results:assessment", self.mark, self.first_name.downcase)
    end
  end
end



