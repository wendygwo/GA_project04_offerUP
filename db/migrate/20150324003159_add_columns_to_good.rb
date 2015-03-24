class AddColumnsToGood < ActiveRecord::Migration
  def change
    add_column :goods, :city, :string
    add_column :goods, :state, :string
    add_column :goods, :zip_code, :string
  end
end
