class AddExpirationDateToStockItems < ActiveRecord::Migration[7.0]
  def change
    add_column :stock_items, :expiration_date, :date
  end
end
