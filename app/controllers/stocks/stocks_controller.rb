class Stocks::StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  def index
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
  
    # 各StockItemに関連するremindersを初期化
    @stock.stock_items.each do |stock_item|
      stock_item.reminders.build if stock_item.reminders.empty?
    end
  
    if @stock.save
      redirect_to stocks_stocks_path, notice: '備蓄アイテムが登録されました。'
    else
      Rails.logger.debug @stock.errors.full_messages # エラーメッセージをログに出力
      render :new, status: :unprocessable_entity
    end
  end

  private

  def stock_params
    params.require(:stock).permit(
      :body,
      stock_items_attributes: [
        :id, :name, :quantity, :storage, :_destroy,
        reminders_attributes: [:id, :expiration_date, :interval_months, :_destroy] # reminders_attributesを追加
      ]
    )
  end
  

  def set_stock
    @stock = Stock.find(params[:id])
  end
end
