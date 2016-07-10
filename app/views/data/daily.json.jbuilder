json.array! @dimensions do |d|
  json.dimension d.key
  json.data do
    json.array! d.daily_records.all, :date, :value
  end
end
