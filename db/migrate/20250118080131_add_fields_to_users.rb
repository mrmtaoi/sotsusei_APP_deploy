class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :email, :string
    add_index :users, :email, unique: true
    add_column :users, :password_digest, :string
    add_column :users, :remember_digest, :string
    add_column :users, :activation_digest, :string
    add_column :users, :activated, :boolean
  end
end
