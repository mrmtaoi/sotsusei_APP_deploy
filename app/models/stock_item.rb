class StockItem < ApplicationRecord
  belongs_to :stock
  has_many :reminders, dependent: :destroy

  validates :name, presence: true
end
  