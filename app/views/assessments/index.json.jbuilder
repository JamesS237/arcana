json.array!(@assessments) do |assessment|
	json.id assessment.id
	json.title assessment.title
	json.average assessment.average.to_i
  json.typeId assessment.type.id
  json.typeName assessment.type.name
  json.subjectId assessment.subject.id
  json.subjectName assessment.subject.name
end
