json.array! @facilities do |facility|
  json.name facility.name
  json.opening facility.opening
  json.closing facility.closing
  json.station facility.station
  json.postcode facility.postcode
  json.address facility.address
  json.lat facility.facility_place.latitude
  json.lng facility.facility_place.longitude
end