class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :name
      t.text :description
      t.float :latitude
      t.float :longitude
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :goods, :users
  end
end
