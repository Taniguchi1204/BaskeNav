json.array! @search_users do |user|
  json.id    user.id
  json.name  user.name
  json.image user.user_image_id
end