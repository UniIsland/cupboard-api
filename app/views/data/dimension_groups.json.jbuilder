@groups.collect!.with_index do |g, i|
  [g, i]
end

json.array! @groups do |g, i|
  json.value i
  json.name g
  json.label(g.presence || 'Select Dimension')
end
