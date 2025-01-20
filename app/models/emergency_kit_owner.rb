class EmergencyKitOwner < ApplicationRecord
  belongs_to :user
  has_many :emergency_kits
  
  enum gender: { male: 0, female: 1, other: 2 }

  # インスタンスメソッド: genderの翻訳を取得
  def gender_i18n
    I18n.t("enums.gender.#{gender}")
  end

  # クラスメソッド: 全てのgenderを翻訳して返す
  def self.genders_i18n
    genders.keys.map { |key| [I18n.t("enums.gender.#{key}"), key] }.to_h
  end

  def self.human_enum_name(enum_name, key)
    I18n.t("enums.#{enum_name}.#{key}")
  end
  
  validates :name, presence: true
  validates :age, presence: true
  validates :gender, presence: true
end
