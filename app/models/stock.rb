class Stock < ApplicationRecord
  belongs_to :user # ユーザーとの関連
  has_many :stock_items, dependent: :destroy
  accepts_nested_attributes_for :stock_items # StockItem をネストして受け入れる
end
