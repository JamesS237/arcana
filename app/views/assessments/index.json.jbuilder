json.array!(@assessments) do |assessment|
	json.id assessment.id
	json.title assessment.title
	json.average assessment.average

	json.type do
		json.id assessment.type.id
		json.name assessment.type.name
	end

	json.subject do
		json.id assessment.subject.id
		json.name assessment.subject.name
	end
end