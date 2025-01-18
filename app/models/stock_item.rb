class StockItem < ApplicationRecord
  belongs_to :stock
  has_many :reminders, foreign_key: :stock_item_id
  accepts_nested_attributes_for :reminders, allow_destroy: true  # リマインダーをネストできるようにする

  validates :name, presence: true
end
  