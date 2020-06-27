class AddAdminsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    add_index :users, :created_at
  end
end
