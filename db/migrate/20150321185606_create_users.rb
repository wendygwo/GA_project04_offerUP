class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :zip_code
      t.string :city
      t.string :state
      t.float :latitude
      t.float :longitude
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
