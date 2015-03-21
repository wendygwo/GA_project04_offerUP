json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :zip_code, :city, :state, :latitude, :longitude, :password_digest
  json.url user_url(user, format: :json)
end
