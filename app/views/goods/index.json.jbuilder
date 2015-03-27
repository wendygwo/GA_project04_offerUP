json.array!(@goods) do |good|
  json.extract! good, :id, :name, :description, :latitude, :longitude, :user_id
  json.user_first good.user.first_name
  json.user_last good.user.last_name
  json.url good_url(good, format: :json)
end
