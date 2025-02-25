class BoardsController < ApplicationController
  before_action :require_login
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  # オートコンプリート機能
  def autocomplete
    query = params[:query]
    @boards = Board.joins(emergency_kits: :kit_items)
                   .where('boards.title LIKE :query OR boards.description LIKE :query OR kit_items.name LIKE :query', query: "%#{query}%")
                   .distinct
  
    render json: @boards.map { |board| 
      {
        id: board.id, 
        title: board.title, 
        description: board.description.truncate(50),
        items: board.emergency_kits.flat_map(&:kit_items).map(&:name).uniq
      } 
    }
  end  # ← ここで明示的に `end` を閉じる

  # 年齢・性別での絞り込み処理（新しく `index` に適用）
  def index
    @boards = Board.all

    # 年代での絞り込み
    if params[:age_group].present?
      case params[:age_group].to_i
      when 0 then @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age < ?', 10)
      when 1 then @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age BETWEEN ? AND ?', 10, 19)
      when 2 then @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age BETWEEN ? AND ?', 20, 29)
      when 3 then @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age BETWEEN ? AND ?', 30, 39)
      when 4 then @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age BETWEEN ? AND ?', 40, 49)
      when 5 then @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age BETWEEN ? AND ?', 50, 59)
      when 6 then @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age BETWEEN ? AND ?', 60, 69)
      when 7 then @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age BETWEEN ? AND ?', 70, 79)
      when 8 then @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age BETWEEN ? AND ?', 80, 89)
      when 9 then @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age BETWEEN ? AND ?', 90, 99)
      when 100 then @boards = @boards.joins(emergency_kits: :owner).where('emergency_kit_owners.age >= ?', 100)
      end
    end

    # 性別での絞り込み
    if params[:gender].present?
      @boards = @boards.joins(emergency_kits: :owner).where(emergency_kit_owners: { gender: params[:gender] })
    end

    @boards = @boards.distinct
  end

  def new
    @board = Board.new
    @emergency_kits = current_user.emergency_kits
  end

  def create
    Rails.logger.debug "Received board params: #{params[:board]}"
    Rails.logger.debug "Selected emergency_kits: #{params[:board][:emergency_kit_ids].reject(&:blank?)}"

    @board = current_user.boards.new(board_params)

    if @board.save
      emergency_kits = EmergencyKit.where(id: params[:board][:emergency_kit_ids].reject(&:blank?))
      @board.emergency_kits = emergency_kits
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
