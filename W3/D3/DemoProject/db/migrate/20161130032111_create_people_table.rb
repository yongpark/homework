class CreatePeopleTable < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.timestamps
      t.string :name, null: false
      t.integer :house_id, null: false
    end
  end
end
