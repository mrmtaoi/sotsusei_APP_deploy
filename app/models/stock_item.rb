class StockItem < ApplicationRecord
  belongs_to :stock
  has_many :reminders, dependent: :destroy # 複数のリマインダーを持つ
  accepts_nested_attributes_for :reminders, allow_destroy: true # リマインダーをネストできるようにする
  belongs_to :category

  validates :name, presence: true
end
