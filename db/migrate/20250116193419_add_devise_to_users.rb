class AddDeviseToUsers < ActiveRecord::Migration[7.0]
  def self.up
    change_table :users do |t|
      # Recoverable
      t.string   :reset_password_token unless column_exists?(:users, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:users, :reset_password_sent_at)

      # Rememberable
      t.datetime :remember_created_at unless column_exists?(:users, :remember_created_at)
    end

    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
  end

  def self.down
    # 逆操作を手動で定義
    remove_index :users, :reset_password_token if index_exists?(:users, :reset_password_token)
    remove_column :users, :reset_password_token if column_exists?(:users, :reset_password_token)
    remove_column :users, :reset_password_sent_at if column_exists?(:users, :reset_password_sent_at)
    remove_column :users, :remember_created_at if column_exists?(:users, :remember_created_at)
  end
end
