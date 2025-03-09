class AddCategoryToKitItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :kit_items, :category, foreign_key: true, null: true
  end
end
