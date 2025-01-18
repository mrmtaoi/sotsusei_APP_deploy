class CreateStockItems < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_items do |t|
      t.references :stock, null: false, foreign_key: true
      t.string :name
      t.integer :quantity
      t.string :storage

      t.timestamps
    end
  end
end
