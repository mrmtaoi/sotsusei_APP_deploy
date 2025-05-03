class Category < ApplicationRecord
  has_many :stock_items, dependent: :destroy
  has_many :kit_items, dependent: :destroy
end
