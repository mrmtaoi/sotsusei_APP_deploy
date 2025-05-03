module SessionsHelper
  # ユーザーをログイン状態にする
  def log_in(user)
    session[:user_id] = user.id
  end

  # ユーザーを記憶する（クッキーに保存）
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # クッキーの情報を削除してユーザーを忘れる
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在ログインしているユーザーを取得（記憶トークンがあれば自動ログイン）
  def current_user
    # インスタンス変数を使わず、メソッド内でユーザーを取得
    @current_user ||= if (user_id = session[:user_id])
                        User.find_by(id: user_id)
                      elsif (user_id = cookies.signed[:user_id])
                        user = User.find_by(id: user_id)
                        if user&.authenticated?(cookies[:remember_token])
                          log_in(user)
                          user
                        end
                      end
  end

  # ユーザーがログインしているかを判定
  def logged_in?
    current_user.present?
  end

  # ログアウト処理（セッションとクッキーの削除）
  def log_out
    forget(current_user)
    session.delete(:user_id)
    # インスタンス変数のクリアは不要
  end
end
