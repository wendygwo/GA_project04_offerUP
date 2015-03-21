require 'bcrypt'
class User < ActiveRecord::Base
	has_secure_password
  geocoded_by :full_address
  after_validation :geocode
  has_many :goods
  has_attached_file :photo, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  has_many :friendships
  has_many :friends, :through => :friendships
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  def full_address
     "#{city}, #{state}, #{zip_code}"
  end
end
