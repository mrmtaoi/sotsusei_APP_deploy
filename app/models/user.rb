class User < ApplicationRecord
  # email　オブジェクトが保存される時点で小文字に変換する
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
  has_many :emergency_kits_owners
end
