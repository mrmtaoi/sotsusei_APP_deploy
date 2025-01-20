class Stocks::StocksController < ApplicationController
  before_action :require_login
  before_action :set_stock, only: [:show, :edit, :update, :destroy]


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

  def destroy
    @stock.destroy
    redirect_to stocks_stocks_path, notice: 'Stock was successfully destroyed.'
  end

  def new
    @stock = Stock.new
    # stock_items と reminders をビルド
    @stock.stock_items.build.reminders.build
  end

  def create
    @stock = Stock.new(stock_params)
    @stock.user = current_user

    if @stock.save
      redirect_to stocks_stocks_path, notice: '備蓄アイテムが登録されました。'
    else
      Rails.logger.debug @stock.errors.full_messages # デバッグ用: エラー内容をログに出力
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @stock = Stock.find(params[:id])
    # stock_items と reminders がすでに存在していない場合のみビルド
    @stock.stock_items.build if @stock.stock_items.empty?
    @stock.stock_items.each do |stock_item|
      stock_item.reminders.build if stock_item.reminders.empty?
    end
  end

  def update
    if @stock.update(stock_params)
      redirect_to stocks_stocks_path, notice: 'アイテムが更新されました。'
    else
      Rails.logger.debug @stock.errors.full_messages # デバッグ用: エラー内容をログに出力
      render :edit, status: :unprocessable_entity
    end
  end  

  private

  def stock_params
    params.require(:stock).permit(
      :body,
      stock_items_attributes: [
        :id, :name, :quantity, :storage, :_destroy,
        reminders_attributes: [:id, :expiration_date, :interval_months, :_destroy]
      ]
    )
  end  

  def set_stock
    @stock = Stock.find(params[:id])
  end
end
