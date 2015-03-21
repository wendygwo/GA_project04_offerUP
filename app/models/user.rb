require 'bcrypt'
class User < ActiveRecord::Base
	has_secure_password
  geocoded_by :full_address
  after_validation :geocode

  def full_address
     "#{city}, #{state}, #{zip_code}"
  end
end
