class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token  # ここに activation_token を追加

  before_save { email.downcase! }
  before_create :create_activation_digest  # ユーザー作成前にダイジェスト生成

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
                     allow_nil: true,
                     unless: :sns_login?

  has_many :stocks, dependent: :destroy
  has_many :emergency_kits, dependent: :destroy
  has_many :emergency_kit_owners, dependent: :destroy
  has_many :boards, dependent: :destroy

  # ランダムなトークンを生成する
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # トークンをハッシュ化する
  def self.digest(token)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(token, cost: cost)
  end

  # メール認証に使用
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end  

  # ログイン情報を記憶する
  def remember
    self.remember_token = User.new_token
    update(remember_digest: User.digest(remember_token))
  end

  # 記憶情報を削除
  def forget
    update(remember_digest: nil)
  end

    # ユーザー削除時に関連するレコードを削除
    def destroy_user
      # 関連する emergency_kit_owners と emergency_kits を削除
      emergency_kit_owners.destroy_all
      emergency_kits.destroy_all
      destroy
    end

  private

  # メール認証用ダイジェストを作成
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  # SNSログイン時はパスワード不要
  def sns_login?
  provider.present? && uid.present?
  end
end
