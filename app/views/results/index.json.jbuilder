json.array!(@results) do |result|
	json.mark result.mark
	json.id result.id

	json.student do
		json.id result.student_id
		json.firstName result.student.first_name
		json.lastName result.student.last_name
		json.fullName (result.student.first_name + ' ' + result.student.last_name)
		json.house result.student.house_name
	end

	json.assessment do 
		json.id result.assessment_id
		json.name result.assessment.title

		json.type do
			json.id result.assessment.type.id
			json.name result.assessment.type.name
		end

		json.subject do
			json.id result.assessment.subject.id
			json.name result.assessment.subject.name
		end
	end
end