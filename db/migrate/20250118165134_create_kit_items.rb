class CreateKitItems < ActiveRecord::Migration[7.0]
  def change
    create_table :kit_items do |t|
      t.references :emergency_kit, null: false, foreign_key: true
      t.string :name
      t.integer :quantity

      t.timestamps
    end
  end
end
