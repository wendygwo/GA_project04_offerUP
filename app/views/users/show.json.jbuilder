json.extract! @user, :id, :first_name, :last_name, :zip_code, :city, :state, :latitude, :longitude, :created_at, :updated_at
json.goods @user.goods, :id, :name, :description
json.friends @user.friends, :id, :first_name, :last_name