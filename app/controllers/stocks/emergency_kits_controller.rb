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
      @emergency_kit_owner = @emergency_kit.owner
      @kit_items = @emergency_kit.kit_items.includes(:reminders) # 関連するアイテムを取得
    end  
  
    def new
      @emergency_kit = EmergencyKit.new
      @gender_options = EmergencyKitOwner.genders_i18n.invert.map { |key, value| [key, value] }  
      @emergency_kit.reminders.build # Reminderオブジェクトを初期化して関連付け    
    end
  
    def create
      Rails.logger.debug "Received params: #{params.inspect}" # リクエスト全体をログ出力
      Rails.logger.debug "Permitted params: #{emergency_kit_params.inspect}" # 許可済みパラメータをログ出力

      user = current_user
      gender = EmergencyKitOwner.genders.key(emergency_kit_params[:gender])
  
      if emergency_kit_params[:owner_name].blank?
        flash[:alert] = "名前の入力は必須です" 
        redirect_to new_stocks_emergency_kit_path  # リダイレクト後にメッセージを表示
        return
      end

      Rails.logger.debug "Reminders attributes: #{params[:emergency_kit][:reminders_attributes].inspect}"

      if params[:emergency_kit][:reminders_attributes]
        params[:emergency_kit][:reminders_attributes].each do |_, reminder_params|
          reminder_params[:user_id] = current_user.id
        end
      end
      
      # パラメータを使用してオーナー情報を取得または作成
      owner = EmergencyKitOwner.find_or_create_by(
        user_id: current_user.id,
        name: emergency_kit_params[:owner_name],
        age: emergency_kit_params[:age],
        gender: emergency_kit_params[:gender]
      )
  
      @emergency_kit = EmergencyKit.new(
        user: user,
        owner: owner,
        storage: emergency_kit_params[:storage],
        reminders_attributes: emergency_kit_params[:reminders_attributes] # 修正ポイント
      )
  
      if @emergency_kit.save
        Rails.logger.debug "Saved emergency kit: #{@emergency_kit.inspect}"
        Rails.logger.debug "Associated reminders: #{@emergency_kit.reminders.inspect}"
        redirect_to stocks_emergency_kits_path, notice: '防災バッグが登録できました！'
      else
        Rails.logger.debug "Failed to save emergency kit: #{@emergency_kit.errors.full_messages}"
        render :new
      end
    end
  
    def edit
    end
  
    def destroy
      # 関連する kit_items を削除
      @emergency_kit.kit_items.destroy_all
      
      # EmergencyKit を削除
      @emergency_kit.destroy
      
      redirect_to stocks_emergency_kits_path, notice: '防災バッグが削除できました'
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
        reminders_attributes: [:interval_months, :user_id]
        )
    end
  end
  
