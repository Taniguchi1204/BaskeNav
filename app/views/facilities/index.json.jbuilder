json.array! @facilities do |facility|
  json.id facility.id
  json.name facility.name
  json.opening facility.opening.strftime("%H時%M分")
  json.closing facility.closing.strftime("%H時%M分")
  json.phone_number facility.phone_number
  json.lat facility.facility_place.latitude
  json.lng facility.facility_place.longitude
end