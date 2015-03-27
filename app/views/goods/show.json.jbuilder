json.extract! @good, :id, :name, :description, :latitude, :longitude, :user_id, :photo, :created_at, :updated_at
json.user_first @good.user.first_name
json.user_last @good.user.last_name
