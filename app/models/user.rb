class User < ApplicationRecord
  attr_accessor :remember_token  # 一時的なトークンを保持するための仮想属性

  before_save { email.downcase! }

  # name のバリデーション
  validates :name, presence: true, length: { maximum: 25 }
  
  # email のバリデーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: { message: "を入力してください" },
                    uniqueness: { case_sensitive: false, message: "はすでに使用されています" },
                    length: { maximum: 105, message: "は最大 %{count} 文字までです" },
                    format: { with: VALID_EMAIL_REGEX, message: "の形式が無効です" }
    
  # password のバリデーション
  has_secure_password
  validates :password, presence: { message: "を入力してください" },
                       length: { minimum: 6, message: "は最低 %{count} 文字必要です" },
                       allow_nil: true

  has_many :stocks
  has_many :emergency_kits
  has_many :emergency_kit_owners, dependent: :destroy
  has_many :boards

  # ランダムなトークンを生成する
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # トークンをハッシュ化して保存する
  def remember
    self.remember_token = User.new_token
    update(remember_digest: BCrypt::Password.create(remember_token))
  end

  # 記憶トークンがダイジェストと一致するか確認
  def authenticated?(token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  # 記憶情報を削除
  def forget
    update(remember_digest: nil)
  end
end
