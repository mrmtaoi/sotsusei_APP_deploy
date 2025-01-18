class Stock < ApplicationRecord
  belongs_to :user
  has_many :stock_items, dependent: :destroy 
  accepts_nested_attributes_for :stock_items  # StockItem をネストして受け入れる
  has_many :reminders, through: :stock_items
  accepts_nested_attributes_for :reminders
end
