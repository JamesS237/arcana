if(@cached)
  json.array! JSON.parse(@results)
else
  json.array!(@results) do |result|
    json.mark result.mark.to_i
    json.id result.id
    json.studentId result.student_id
    json.studentName (result.student.first_name + ' ' + result.student.last_name)
    json.studentHouse result.student.house_name
    json.assessmentId result.assessment_id
    json.assessmentName result.assessment.title
    json.typeId result.assessment.type.id
    json.typeName result.assessment.type.name
    json.subjectId result.assessment.subject.id
    json.subjectName result.assessment.subject.name
  end
end
