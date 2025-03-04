class CreateBoardEmergencyKits < ActiveRecord::Migration[7.0]
  def change
    create_table :board_emergency_kits do |t|
      t.references :board, null: false, foreign_key: true
      t.references :emergency_kit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
