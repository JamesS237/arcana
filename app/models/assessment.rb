class Assessment < ActiveRecord::Base
  searchkick suggest: ["title"]
  has_many :results
  belongs_to :type
  belongs_to :subject
  validates :title, presence: true
  validates :subject_id, presence: true
  validates :type_id, presence: true

  def self.cache(assessments)
    if(assessments == :all)
      assessments = Assessment.all
    end

    hash = {:assessments => []}
    assessments.each do |r|
      hash[:assessments] << r.get_jsonable_hash
    end
    $redis.set("queries:assessments:all", JSON.generate(hash))
  end

  def get_jsonable_hash
    hash = {}
    hash[:id] = self.id
    hash[:average] = self.average.to_i
    hash[:title] = self.title
    hash[:typeId] = self.type.id
    hash[:typeName] = self.type.name
    hash[:subjectId] = self.subject.id
    hash[:subjectName] = self.subject.name
    hash
  end

  def to_param
    title.gsub(' ', '-')
  end

  def average
    self.results.average("mark")
  end

  def exam?
    self.type.name == "Exam"
  end

  def self.uncomplete(student)
    complete = student.results
    return Assessment.all if complete == []
    Assessment.find(:all, :conditions => ['id not in (?)', complete.map(&:assessment_id)])
  end
end
