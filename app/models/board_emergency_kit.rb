class BoardEmergencyKit < ApplicationRecord
  belongs_to :board
  belongs_to :emergency_kit
end
