class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :address, null: false
    end
  end
end
