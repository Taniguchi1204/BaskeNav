json.array! @reserve_facilities do |event|
  json.id event.id
  json.start event.start
  json.end event.finish
end