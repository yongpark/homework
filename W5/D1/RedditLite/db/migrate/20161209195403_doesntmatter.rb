class Doesntmatter < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :session_token
    add_column :users, :session_token, :string, null: false
  end
end
