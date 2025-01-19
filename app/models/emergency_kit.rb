class EmergencyKit < ApplicationRecord
  belongs_to :user
  belongs_to :owner, class_name: 'EmergencyKitOwner'
  has_many :kit_items
  has_one :reminder, dependent: :destroy
  accepts_nested_attributes_for :reminder

end
