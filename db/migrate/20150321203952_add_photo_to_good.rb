class AddPhotoToGood < ActiveRecord::Migration
  def self.up
    add_attachment :goods, :photo
    add_attachment :users, :photo
  end

  def self.down
    remove_attachment :goods, :photo
    remove_attachment :users, :photo
  end

  
end
