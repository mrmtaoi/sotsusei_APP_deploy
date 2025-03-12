class Stocks::StocksController < ApplicationController
  before_action :require_login
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

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
    @stock.assign_attributes(stock_params)
  
    # stock_items の reminder に user を設定
    @stock.stock_items.each do |stock_item|
      stock_item.reminders.each do |reminder|
        reminder.user = current_user if reminder.user.nil? # user を設定
      end
    end
  
    if @stock.save
      redirect_to stocks_stocks_path, notice: '備蓄アイテムが更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def stock_params
    params.require(:stock).permit(
      :body,
      stock_items_attributes: [
        :id, :name, :category_id, :quantity, :storage, :_destroy,
        reminders_attributes: [:id, :expiration_date, :interval_months, :_destroy]
      ]
    )
  end  

  def set_stock
    @stock = Stock.find(params[:id])
  end
end