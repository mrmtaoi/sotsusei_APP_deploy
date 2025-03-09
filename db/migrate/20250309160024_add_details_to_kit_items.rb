class AddDetailsToKitItems < ActiveRecord::Migration[7.0]
  def change
    add_column :kit_items, :meal_count, :integer
    add_column :kit_items, :volume, :decimal
    add_column :kit_items, :sub_category, :string
  end
end
