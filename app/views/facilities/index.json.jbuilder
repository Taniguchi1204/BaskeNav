json.array! @facilities do |facility_place|
  json.id           facility_place.facility.id
  json.name         facility_place.facility.name
  json.opening      facility_place.facility.opening.strftime("%H時%M分")
  json.closing      facility_place.facility.closing.strftime("%H時%M分")
  json.phone_number facility_place.facility.phone_number
  json.address      facility_place.facility.address
  json.station      facility_place.facility.station
  json.lat          facility_place.latitude
  json.lng          facility_place.longitude
end