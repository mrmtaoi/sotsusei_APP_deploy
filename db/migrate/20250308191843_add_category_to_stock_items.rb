class AddCategoryToStockItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :stock_items, :category, null: true, foreign_key: true
  end
end
