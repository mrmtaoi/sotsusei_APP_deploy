class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false, unique: true
      t.string :encrypted_password, null: false, default: "" # deviseのパスワードを保存するカラム
      t.boolean :activated, default: false
      t.datetime :activated_at # アクティベーション日付

      t.timestamps
    end

    # インデックスを追加
    add_index :users, :email, unique: true
  end
end
