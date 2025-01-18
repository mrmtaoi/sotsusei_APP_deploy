class CreateReminders < ActiveRecord::Migration[7.0]
  def change
    create_table :reminders do |t|
      t.references :user, null: false, foreign_key: true  # usersテーブルと関連付け
      t.references :kit_item, foreign_key: { to_table: :kit_items }  # kit_itemsテーブルと関連付け
      t.references :stock_item, foreign_key: { to_table: :stock_items }  # stock_itemsテーブルと関連付け
      t.references :emergency_kit, foreign_key: true  # emergency_kitsテーブルと関連付け
      t.text :reminders
      t.integer :interval_months, null: false  # 必須の月単位サイクル
      t.date :expiration_date
      t.timestamps  # created_at, updated_at
      t.index [:user_id, :kit_item_id, :stock_item_id], unique: true, name: 'index_reminders_on_user_kit_stock'
    end
  end
end
