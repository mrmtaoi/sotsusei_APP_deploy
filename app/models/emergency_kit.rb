class EmergencyKit < ApplicationRecord
  belongs_to :user
  belongs_to :owner, class_name: 'EmergencyKitOwner'
  has_many :kit_items, dependent: :destroy
  has_many :reminders, dependent: :destroy
  accepts_nested_attributes_for :reminders, allow_destroy: true

  has_many :board_emergency_kits
  has_many :boards, through: :board_emergency_kits
  before_create :generate_share_token
  
  private
  
  def generate_share_token
    self.share_token ||= SecureRandom.urlsafe_base64(16)
  end
end
