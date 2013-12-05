json.array!(@types) do |type|
  json.extract! type, :name, :weight
  json.url type_url(type, format: :json)
end