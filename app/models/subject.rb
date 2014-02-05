class Subject < ActiveRecord::Base
  searchkick

  has_many :assessments
  has_many :averages

  validates :name, presence: true

  def leader
    leader_id = $redis.zrevrange("results:#{self.redis_name}", 0, 0)[0].to_i
    return nil if leader_id == 0
    Student.find(leader_id);
  end

  def results
    Result.where('results.assessment_id IN(SELECT assessments.id FROM assessments WHERE subject_id = ?)', self.id)
  end

  def to_param
    self.name.gsub(' ', '-')
  end

  def redis_name
    self.name.downcase.gsub(' ', '')
  end
end


