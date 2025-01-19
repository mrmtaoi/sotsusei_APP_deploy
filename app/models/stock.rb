class Stock < ApplicationRecord
  belongs_to :user  # ユーザーとの関連
  has_many :reminders
  has_many :stock_items  # 複数の StockItem を持つ
  accepts_nested_attributes_for :stock_items  # StockItem をネストして受け入れる
end
