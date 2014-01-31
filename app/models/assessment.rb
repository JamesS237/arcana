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

  def average
    self.results.average("mark")
  end

  def self.search(query)
    Assessment.all.where('title LIKE(?)', '%' + query + '%')
  end

  def self.uncomplete(student)
    complete = student.results
    return Assessment.all if complete == []
    Assessment.find(:all, :conditions => ['id not in (?)', complete.map(&:assessment_id)])
  end
end
