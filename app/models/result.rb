class Result < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :student
  
  validates :student_id, presence: true
  validates :mark, presence: true
  validates :assessment_id, presence: true
end
