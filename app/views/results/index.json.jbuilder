json.array!(@results) do |result|
	json.mark result.mark
	json.id result.id
	json.assessment_id result.assessment_id
	json.student_id result.student_id
	json.assessment_name result.assessment.title
	json.student_name  result.student.full_name
end