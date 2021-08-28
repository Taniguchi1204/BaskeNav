json.array! @facilities do |facilit
  json.id facility.id
  json.name facility.facility.name
  json.opening facility.facility.opening.strftime("%H時%M分")
  json.closing facility.facility.closing.strftime("%H時%M分")
  json.phone_number facility.facility.phone_number
  json.lat facility.latitude
  json.lng facility.longitude
end