class KitItem < ApplicationRecord
  belongs_to :emergency_kit
  has_many :reminders, dependent: :destroy
  accepts_nested_attributes_for :reminders, allow_destroy: true
  belongs_to :category
end
  