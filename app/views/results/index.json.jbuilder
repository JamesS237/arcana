json.array!(@results) do |result|
  json.extract! result, :student_id, :assessment_id, :mark
  json.url result_url(result, format: :json)
end