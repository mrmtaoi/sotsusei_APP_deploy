class Stocks::KitItemsController < ApplicationController
  before_action :set_emergency_kit
  before_action :set_kit_item, only: [:edit, :update, :show, :destroy]

  def index
    @kit_items = @emergency_kit.kit_items
  end

  def show
    # @kit_item が設定されていない場合に新しいインスタンスを作成
    @kit_item = @emergency_kit.kit_items.first || @emergency_kit.kit_items.build
    @kit_items = @emergency_kit.kit_items.includes(:reminders)
  end
  
  def edit
  end  

  def update
    if @kit_item.update(kit_item_params)
      redirect_to stocks_emergency_kit_path(@kit_item.emergency_kit), notice: 'アイテムが更新されました'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @kit_item.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@kit_item) }
      format.html { redirect_to stocks_emergency_kit_path(@kit_item.emergency_kit), notice: "アイテムが削除できました" }
    end
  end
  
  def new
    @kit_item = KitItem.new
    @kit_item.reminders.build # 新しい reminder を追加する
  end
  
  def create
    Rails.logger.debug "Received params: #{params.inspect}"
  
    @kit_item = @emergency_kit.kit_items.build(kit_item_params)
  
    if @kit_item.save
      redirect_to stocks_emergency_kit_path(@emergency_kit), notice: 'アイテムが追加されました！'
    else
      Rails.logger.debug "Errors: #{@kit_item.errors.full_messages.join(', ')}"
      render 'stocks/emergency_kits/show', status: :unprocessable_entity
    end
  end
  

  private
  
  def kit_item_params
    params.require(:kit_item).permit(:name, :quantity, reminders_attributes: [:expiration_date])
  end

  # kit_item を設定
  def set_kit_item
    @kit_item = KitItem.find(params[:id])
  end
end
