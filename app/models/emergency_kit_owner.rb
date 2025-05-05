class EmergencyKitOwner < ApplicationRecord
  belongs_to :user
  has_many :emergency_kits, foreign_key: :owner_id, dependent: :destroy, inverse_of: :owner
  enum :gender, { male: 0, female: 1, other: 2 }

  def self.genders_i18n
    { '男性' => :male, '女性' => :female, 'その他' => :other }
  end

  validates :name, presence: { message: "なまえは必須項目です" }

  # インスタンスメソッド: genderの翻訳を取得
  def gender_i18n
    I18n.t("enums.gender.#{gender}")
  end

  private

  def normalize_gender
    return if gender.blank?

    # 日本語をenumシンボルに変換
    if GENDER_TRANSLATION.key?(gender)
      self.gender = GENDER_TRANSLATION[gender]
    else
      errors.add(:gender, "は無効な値です")
    end
  end
end
