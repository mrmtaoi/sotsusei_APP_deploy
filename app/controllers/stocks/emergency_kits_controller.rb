class Stocks::EmergencyKitsController < ApplicationController
  before_action :require_login
  before_action :set_emergency_kit, only: [:show, :edit, :update, :destroy]
  
    def index
      @emergency_kits = EmergencyKit.where(user: current_user) # ユーザーの防災バッグを取得
    end
  
    def all
      @emergency_kits = EmergencyKit.where(user: current_user) # ユーザーの防災バッグ一覧を取得
      @stocks = Stock.where(user: current_user) # ユーザーの備蓄一覧を取得
    end
  
    def show
      # set_emergency_kit メソッドで既に @emergency_kit が設定されているため、再度 find は不要です
      @emergency_kit_owner = @emergency_kit.owner
      @kit_items = @emergency_kit.kit_items.includes(:reminders) # 関連するアイテムを取得
    end  
  
    def new
      @emergency_kit = EmergencyKit.new
      @gender_options = EmergencyKitOwner.genders.keys.map do |key|
        [I18n.t("enums.gender.#{key}"), key]
      end
      @emergency_kit.build_reminder # Reminder を初期化
    end
  
    def create
      user = current_user
      gender = EmergencyKitOwner.genders.key(emergency_kit_params[:gender])
  
      # パラメータを使用してオーナー情報を取得または作成
      owner = EmergencyKitOwner.find_or_create_by(
        user_id: current_user.id,
        name: emergency_kit_params[:owner_name],
        age: emergency_kit_params[:age],
        gender: emergency_kit_params[:gender]
      )
  
      # EmergencyKit の作成
      @emergency_kit = EmergencyKit.new(
        user: user,
        owner: owner,
        body: emergency_kit_params[:body],
        storage: emergency_kit_params[:storage]
      )

      
  
      if @emergency_kit.save
        # 保存に成功した場合
        redirect_to stocks_emergency_kits_path, notice: 'Emergency kit was successfully created.'
      else
        # 保存に失敗した場合
        render :new
      end
    end
  
    def edit
      # set_emergency_kit メソッドで既に @emergency_kit が設定されているため、再度 find は不要です
    end
  
    def destroy
      # 関連する kit_items を削除
      @emergency_kit.kit_items.destroy_all
      
      # EmergencyKit を削除
      @emergency_kit.destroy
      
      redirect_to stocks_emergency_kits_path, notice: '防災バッグが削除されました。'
    end
    
    
    private
  
    def set_emergency_kit
      @emergency_kit = EmergencyKit.find(params[:id])
    end
  
    def emergency_kit_params
      params.require(:emergency_kit).permit(
        :storage, 
        :owner_name, 
        :age, 
        :gender, 
        reminder_attributes: [:interval_months]
      )
    end
  end
  