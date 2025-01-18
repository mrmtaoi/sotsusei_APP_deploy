class CreateEmergencyKitOwners < ActiveRecord::Migration[7.0]
  def change
    create_table :emergency_kit_owners do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :age
      t.integer :gender, default: 0 # 0: male, 1: female, nil: unknown

      t.timestamps
    end
  end
end
