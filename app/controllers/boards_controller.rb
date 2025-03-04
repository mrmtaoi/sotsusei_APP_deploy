class BoardsController < ApplicationController
  before_action :require_login
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  # フリーワード検索結果を返すAPIエンドポイント
  def autocomplete
    @boards = Board.where('title LIKE ?', "%#{params[:query]}%")
    render json: @boards.select(:id, :title)
  end

  def index
    @boards = Board.all
  
    # フリーワード検索
  # フリーワード検索
  if params[:search].present?
    @boards = @boards.joins(emergency_kits: :kit_items).where('title LIKE ? OR description LIKE ? OR kit_items.name LIKE ?', 
                                                            "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
  end
  
    # 年代と性別で絞り込み
    if params[:age_group].present?
      case params[:age_group].to_i
      when 0
        # 10代未満（0〜9歳）
        @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age < ?', 10)
      when 1
        # 10代（10〜19歳）
        @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age >= ? AND emergency_kit_owners.age < ?', 10, 20)
      when 2
        # 20代（20〜29歳）
        @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age >= ? AND emergency_kit_owners.age < ?', 20, 30)
      when 3
        # 30代（30〜39歳）
        @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age >= ? AND emergency_kit_owners.age < ?', 30, 40)
      when 4
        # 40代（40〜49歳）
        @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age >= ? AND emergency_kit_owners.age < ?', 40, 50)
      when 5
        # 50代（50〜59歳）
        @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age >= ? AND emergency_kit_owners.age < ?', 50, 60)
      when 6
        # 60代（60〜69歳）
        @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age >= ? AND emergency_kit_owners.age < ?', 60, 70)
      when 7
        # 70代（70〜79歳）
        @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age >= ? AND emergency_kit_owners.age < ?', 70, 80)
      when 8
        # 80代（80〜89歳）
        @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age >= ? AND emergency_kit_owners.age < ?', 80, 90)
      when 9
        # 90代（90〜99歳）
        @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age >= ? AND emergency_kit_owners.age < ?', 90, 100)
      when 100
        # 100歳以上
        @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age >= ?', 100)
      end
    end
  
    # 性別で絞り込み
    if params[:gender].present?
      @boards = @boards.joins(emergency_kits: :owner).where(emergency_kit_owners: { gender: params[:gender] })
    end
  
    @boards = @boards.distinct
  end  

  def new
    @board = Board.new
    @emergency_kits = current_user.emergency_kits # ユーザーの防災バッグを取得
  end

  def create
    Rails.logger.debug "Received board params: #{params[:board]}"
    Rails.logger.debug "Selected emergency_kits: #{params[:board][:emergency_kit_ids].reject(&:blank?)}"

  @board = current_user.boards.new(board_params)

    if @board.save
      emergency_kits = EmergencyKit.where(id: params[:board][:emergency_kit_ids].reject(&:blank?))
      @board.emergency_kits = emergency_kits  # ここで 1回だけ関連付け
      redirect_to @board, notice: '投稿が作成されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end  

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to @board, notice: '防災バッグの投稿を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, notice: '防災バッグの投稿を削除しました'
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :description, :is_public, emergency_kit_ids: [])
  end  
  
end
