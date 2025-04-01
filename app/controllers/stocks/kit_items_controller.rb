class Stocks::KitItemsController < ApplicationController
  before_action :set_emergency_kit
  before_action :set_kit_item, only: [:edit, :update, :show, :destroy]

  def index
    @kit_items = @emergency_kit.kit_items
  end

  def create
    @kit_item = @emergency_kit.kit_items.build(kit_item_params)

    if @kit_item.save
      # Reminderの作成処理
      if params[:reminders][:expiration_date].present?
        @kit_item.reminders.create(
          expiration_date: params[:reminders][:expiration_date],
          user_id: current_user.id # user_id を指定
        )
      end
      redirect_to stocks_emergency_kit_path(@emergency_kit), notice: "アイテムが追加されました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # リマインダーが未設定の場合、新しいリマインダーを作成してフォームに表示
    @kit_item.reminders.build if @kit_item.reminders.empty?
  end

  def update
    if @kit_item.update(kit_item_params)
      # reminders_attributesが送信されている場合
      if kit_item_params[:reminders_attributes].present?
        kit_item_params[:reminders_attributes].each do |_, reminder_params|
          reminder = @kit_item.reminders.find_or_initialize_by(id: reminder_params[:id])
          reminder.assign_attributes(reminder_params)
          reminder.user_id = current_user.id # user_idを設定
          reminder.save # 保存
        end
      end
  
      redirect_to stocks_emergency_kit_path(@emergency_kit), notice: 'アイテムが更新されました。'
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
    params.require(:kit_item).permit(:name, :quantity, :category_id,
      reminders_attributes: [:id, :expiration_date, :_destroy, :user_id])
  end  
end