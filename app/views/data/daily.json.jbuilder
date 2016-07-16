json.array! @dimensions do |d|
  json.dimension d.key
  json.data do
    json.array! nullify_missing_dates(d.daily_records.all), :date, :value
  end
end
