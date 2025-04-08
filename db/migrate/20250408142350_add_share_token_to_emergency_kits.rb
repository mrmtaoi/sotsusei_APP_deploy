class AddShareTokenToEmergencyKits < ActiveRecord::Migration[7.0]
  def change
    add_column :emergency_kits, :share_token, :string
  end
end
