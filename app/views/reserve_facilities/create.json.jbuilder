json.array! @reserve_facilities do |event|
  json.id          event.id
  json.facility_id event.facility_id
  json.start       event.start
  json.end         event.finish
  json.number      event.number
  json.comment     event.comment
  json.with_friend event.with_friend

  if event.confirm == false
    json.title "承認待ち"
    json.color "#FF773E"
  else
    json.title "予約確定"
    json.color ""
  end

  json.user         event.user_id
  json.name         event.user.name
  json.phone_number event.user.phone_number
  json.email        event.user.email
end