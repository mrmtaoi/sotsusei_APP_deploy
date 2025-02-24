class Board < ApplicationRecord
  belongs_to :user
  has_many :board_emergency_kits, dependent: :destroy
  has_many :emergency_kits, through: :board_emergency_kits

  validates :title, presence: true
end
