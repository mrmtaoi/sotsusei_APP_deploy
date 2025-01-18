class Stock < ApplicationRecord
  belongs_to :user
  
  has_many :stock_items, dependent: :destroy
  accepts_nested_attributes_for :stock_items, allow_destroy: true
end
