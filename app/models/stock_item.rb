class StockItem < ApplicationRecord
  belongs_to :stock
  has_many :reminders, inverse_of: :stock_item, dependent: :destroy
  accepts_nested_attributes_for :reminders, allow_destroy: true # リマインダーをネストできるようにする
  belongs_to :category

  validates :name, presence: true
end
