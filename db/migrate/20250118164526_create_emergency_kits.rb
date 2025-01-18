class CreateEmergencyKits < ActiveRecord::Migration[7.0]
  def change
    create_table :emergency_kits do |t|
      t.references :user, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: { to_table: :emergency_kit_owners }  # 修正箇所
      t.text :body
      t.string :storage
      t.timestamps
    end
  end
end
