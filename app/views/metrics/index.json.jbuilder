metric_by_path = {}
@metrics.each do |m|
  paths = m.name.split('.')
  depth = paths.size
  metric_by_path[paths[0]] ||= {}
  key = (depth == 1 ? '' : paths[1..-1].join('.'))
  metric_by_path[paths[0]][key] = m.name
end

metrics = []
metric_by_path.each do |k,v|
  metrics << {
    name: k,
    depth: 1,
    label: k,
    root: k,
    dummy: v.delete('').nil?,
    has_children: v.size > 0
  }
  v.each do |key,name|
    metrics << {
      name: name,
      depth: 2,
      label: key,
      root: k
    }
  end
end

json.array! metrics
