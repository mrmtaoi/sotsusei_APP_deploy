class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers  # URL ヘルパーをインクルード
  default from: "lets.stock2025@gmail.com"

  def account_activation(user)
    @user = user
    # 設定されたホストを使用してURLを生成
    @activation_url = account_activation_url(user.activation_token, email: user.email, host: Rails.env.production? ? "https://sotsusei-app-deploy-4.onrender.com" : "localhost:3000")
    mail to: user.email, subject: "アカウントの有効化"
  end
end
