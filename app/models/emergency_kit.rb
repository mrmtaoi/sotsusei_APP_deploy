class EmergencyKit < ApplicationRecord
  belongs_to :user
  belongs_to :owner, class_name: 'EmergencyKitOwner'
  has_many :kit_items
  has_many :reminders, dependent: :destroy
  accepts_nested_attributes_for :reminders, allow_destroy: true

  has_many :board_emergency_kits
  has_many :boards, through: :board_emergency_kits
end
