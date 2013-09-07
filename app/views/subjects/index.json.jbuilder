json.array!(@subjects) do |subject|
  json.extract! subject, :name, :elective
  json.url subject_url(subject, format: :json)
end