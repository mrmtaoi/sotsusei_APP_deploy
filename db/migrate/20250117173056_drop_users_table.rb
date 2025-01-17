class DropUsersTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :users
  end

  def down
    # 必要に応じてテーブルを復元するコードを書く
  end
end
