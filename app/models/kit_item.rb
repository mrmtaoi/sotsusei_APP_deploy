class KitItem < ApplicationRecord
  belongs_to :emergency_kit
  has_many :reminders, foreign_key: :stock_item_id
  accepts_nested_attributes_for :reminders, allow_destroy: true # リマインダーをネストできるようにする
end
  