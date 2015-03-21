json.array!(@goods) do |good|
  json.extract! good, :id, :name, :description, :latitude, :longitude, :user_id
  json.url good_url(good, format: :json)
end
