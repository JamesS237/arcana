json.array!(@assessments) do |assessment|
  json.extract! assessment, :subject_id, :type_id, :title, :exam
  json.url assessment_url(assessment, format: :json)
end