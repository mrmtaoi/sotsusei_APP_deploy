class KitItem < ApplicationRecord
  belongs_to :emergency_kit
  has_many :reminders, dependent: :destroy
  accepts_nested_attributes_for :reminders, allow_destroy: true,
                                            reject_if: proc { |attributes| attributes['expiration_date'].blank? }

  belongs_to :category
end
