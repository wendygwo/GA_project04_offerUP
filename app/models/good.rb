class Good < ActiveRecord::Base
  searchkick word_middle: [:name, :description],
              locations: ['location']
  geocoded_by :full_address
  after_validation :geocode
  
  def search_data
    attributes.merge location: [latitude, longitude]
  end
  belongs_to :user
  has_attached_file :photo, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  # Validate size of attached image is less than 1MB
  validates_with AttachmentSizeValidator, :attributes => :photo, :less_than => 1.megabytes
  
  # Validates presence of first and last name, and city and state fields
  validates_presence_of :name, :description

  def full_address
     "#{city}, #{state}, #{zip_code}"
  end
end
