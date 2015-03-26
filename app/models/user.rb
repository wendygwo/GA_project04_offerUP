require 'bcrypt'
class User < ActiveRecord::Base
	searchkick word_middle: [:first_name, :last_name, :email, :city, :state, :zip_code]
  validates_uniqueness_of :email
  has_secure_password
  geocoded_by :full_address
  after_validation :geocode
  has_many :goods
  has_attached_file :photo, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  # Validate size of attached image is less than 1MB
  validates_with AttachmentSizeValidator, :attributes => :photo, :less_than => 1.megabytes

  # Validates e-mail for uniqueness and presence and format
  validates :email, uniqueness: true, presence: true, format:{ with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i , multiline: true }
  # Validates presence of first and last name, and city and state fields
  validates_presence_of :first_name, :last_name, :city, :state

  has_many :friendships
  has_many :friends, :through => :friendships


  def full_address
     "#{city}, #{state}, #{zip_code}"
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.forgot_password(self).deliver# This sends an e-mail with a link for the user to reset the password
  end
    # This generates a random password reset token for the user
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
