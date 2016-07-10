json.array! @namespaces do |ns|
  json.(ns, :name, :path, :label)
end
