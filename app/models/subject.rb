class Subject < ActiveRecord::Base
  has_many :assessments
  has_many :averages

  validates :name, presence: true

  def leader
    leader_id = $redis.zrevrange("results:#{self.redis_name}", 0, 0)[0].to_i
    Student.find(leader_id);
  end

  def to_param
    self.name.gsub(' ', '-')
  end

  def redis_name
    self.name.downcase.gsub(' ', '')
  end

  def self.search(query)
    Subject.all.where('name LIKE(?)', '%' + query + '%')
  end
end


