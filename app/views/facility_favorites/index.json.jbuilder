json.array! @facilities do |favorite|
  json.id           favorite.facility.id
  json.name         favorite.facility.name
  json.opening      favorite.facility.opening.strftime("%H時%M分")
  json.closing      favorite.facility.closing.strftime("%H時%M分")
  json.phone_number favorite.facility.phone_number
  json.address      favorite.facility.address
  json.station      favorite.facility.station
  json.lat          favorite.facility.facility_place.latitude
  json.lng          favorite.facility.facility_place.longitude
end