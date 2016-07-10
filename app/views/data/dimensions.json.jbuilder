@dimension_keys.collect! do |d|
  {
    key: d,
    data: d.split('|').collect {|s| s.split ':'}.to_h
  }
end

json.array! @dimension_keys
