class Stocks::KitItemsController < ApplicationController
  before_action :set_emergency_kit
  before_action :set_kit_item, only: [:edit, :update, :show, :destroy]

  def index
    @kit_items = @emergency_kit.kit_items
  end

  def new
    @kit_item = @emergency_kit.kit_items.build
    @kit_item.reminders.build  # KitItemに紐づくReminderを作成
  end

  def create
    @kit_item = @emergency_kit.kit_items.build(kit_item_params)

    if @kit_item.save
      @kit_item.reminders.create(reminder_params)  # reminder_params を適切に渡す
      redirect_to stocks_emergency_kit_path(@emergency_kit), notice: 'Kit item was successfully added.'
    else
      render :new, alert: 'Failed to add kit item.'
    end
  end
  
  def edit
  end  
  
  def update
    if @kit_item.update(kit_item_params)
      redirect_to stocks_emergency_kit_path(@kit_item.emergency_kit), notice: 'アイテムが更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @kit_item.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@kit_item) }
      format.html { redirect_to stocks_emergency_kit_path(@kit_item.emergency_kit), notice: "Item was successfully destroyed." }
    end
  end
  
  
  private
  
  def set_emergency_kit
    @emergency_kit = EmergencyKit.find(params[:emergency_kit_id])
  end
  
  def set_kit_item
    @kit_item = @emergency_kit.kit_items.find(params[:id])
  end
  
  def kit_item_params
    params.require(:kit_item).permit(:name, :quantity, reminders_attributes: [:expiration_date])
  end
end

def reminder_params
  params.require(:reminders).permit(:expiration_date)  # 必要なパラメータを追加
end