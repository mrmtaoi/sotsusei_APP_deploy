class Stocks::StocksController < ApplicationController
  before_action :require_login

  def require_login
    unless user_logged_in?
      flash[:alert] = "ログインしてください。"
      redirect_to login_path
      logger.debug "User not logged in! Redirecting to login page."
    else
      logger.debug "User logged in with ID: #{session[:user_id]}"
    end
  end

  def index
    @stocks = current_user.stocks
  end

  def show
    # showアクションは省略
  end

  def new
    @stock = Stock.new
    stock_item = @stock.stock_items.build
    stock_item.reminders.build
  end

  def create
    Rails.logger.debug "Received params: #{params.inspect}"
    logger.debug "Session User ID: #{session[:user_id]}"
    logger.debug "Current User: #{current_user.inspect}"

    @stock = Stock.new(stock_params)
    @stock.user = current_user

      # Reminderのkit_itemとemergency_kitをnilに設定
    @stock.stock_items.each do |stock_item|
      stock_item.reminders.each do |reminder|
        reminder.kit_item = nil
        reminder.emergency_kit = nil
        reminder.user = current_user  # ここでReminderにuserを設定
        reminder.interval_months = reminder.interval_months.blank? ? nil : reminder.interval_months # 空文字をnilに変換
      end
    end

    if @stock.save
      redirect_to stocks_stocks_path, notice: '備蓄アイテムが登録されました。'
    else
      Rails.logger.debug @stock.errors.full_messages # エラー内容をログに出力
      render :new, status: :unprocessable_entity
    end
  end

  private

  def stock_params
    params.require(:stock).permit(
      :body,
      stock_items_attributes: [
        :name, :quantity, :storage,
        reminders_attributes: [:expiration_date, :interval_months]
      ]
    )
  end
end
