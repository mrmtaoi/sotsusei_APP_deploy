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
    @stock.stock_items.build # 子モデルの初期化
    @stock.stock_items.each do |stock_item|
      stock_item.reminders.build # 各StockItemに対してremindersを初期化
    end
  end

  def create
    @stock = Stock.new(stock_params)
    @stock.user = current_user
  
    # StockItem に関連する reminders が必要な場合のみ初期化
    @stock.stock_items.each do |stock_item|
      stock_item.reminders.build if stock_item.reminders.blank?
    end
  
    if @stock.save
      redirect_to stocks_stocks_path, notice: '備蓄アイテムが登録されました。'
    else
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
