json.array! @facilities do |facility|
  json.lat facility.facility_place.latitude
  json.lng facility.facility_place.longitude
end