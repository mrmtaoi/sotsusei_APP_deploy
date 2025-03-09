class Category < ApplicationRecord
  has_many :stock_items
  has_many :kit_items
end
