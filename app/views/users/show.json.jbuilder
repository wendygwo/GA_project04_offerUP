json.extract! @user, :id, :first_name, :last_name, :zip_code, :city, :state, :latitude, :longitude, :created_at, :updated_at, :photo
json.goods @user.goods, :id, :name, :description, :photo
json.friends @user.friends, :id, :first_name, :last_name, :city, :state, :zip_code, :photo
