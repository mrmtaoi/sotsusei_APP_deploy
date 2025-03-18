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
      @kit_items = @emergency_kit.kit_items.includes(:reminders)
    
      # カテゴリーごとの必要量（仮のデータ）
      required_quantities = {
        "食料" => 9, "飲料" => 9, "医療・衛生用品" => 3,
        "防寒具" => 2, "寝具" => 2, "衣類" => 3,
        "乾電池" => 6, "ライト" => 1, "ラジオ" => 1,
        "スマホ充電機器" => 1, "その他" => 2
      }
    
      # アドバイスメッセージ（不足時の提案）
      advice_messages = {
        "食料" => "食料が不足しているかもしれません。防災バッグには3日分の食事は備えておきたいです。",
        "飲料" => "水が不足しています。1人1日3リットルを目安に備えましょう。",
        "医療・衛生用品" => "応急処置セットが足りない可能性があります。消毒液や包帯などを準備しましょう。",
        "防寒具" => "寒さ対策が不十分かもしれません。防寒シートやカイロを追加しましょう。",
        "寝具" => "寝具が不足しているようです。簡易マットや寝袋を用意しましょう。",
        "衣類" => "着替えの用意は十分ですか？長期間避難を考慮して準備しましょう。",
        "乾電池" => "電池が足りないかもしれません。ラジオや懐中電灯のために備えておきましょう。",
        "ライト" => "夜間の行動を考え、懐中電灯やランタンを追加しましょう。",
        "ラジオ" => "情報収集用のラジオを準備しましょう。電池式や手回し式が便利です。",
        "スマホ充電機器" => "スマホ充電機器が不足しています。モバイルバッテリーを準備しましょう。",
        "その他" => "その他の必要なアイテムもチェックしましょう。"
      }
    
      # 現在のバッグ内のアイテム数を集計
      current_quantities = @kit_items.group(:category_id).sum(:quantity)
    
      # 不足アイテムの抽出
      @missing_items = required_quantities.map do |category_name, required_quantity|
        category = Category.find_by(name: category_name)
        next unless category
    
        current_quantity = current_quantities[category.id] || 0
        if current_quantity < required_quantity
          {
            name: category_name,
            missing: required_quantity - current_quantity,
            advice: advice_messages[category_name]
          }
        end
      end.compact
    end
    
    
  
    def new
      @emergency_kit = EmergencyKit.new
      @gender_options = EmergencyKitOwner.genders_i18n.map { |key, value| [key, value] }
      @emergency_kit.reminders.build # Reminderオブジェクトを初期化して関連付け   
      Rails.logger.debug("Gender Options: #{@gender_options}") 
    end
  
    def create
      Rails.logger.debug("Processed Gender: #{emergency_kit_params[:gender]}")

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
        redirect_to stocks_emergency_kits_path, notice: '防災バッグを作成しました！さっそくバッグを開いてアイテムを登録してみましょう！'
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

      # 関連する 掲示板投稿 を削除
      @emergency_kit.board_emergency_kits.destroy_all
      
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
  
