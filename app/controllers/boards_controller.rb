class BoardsController < ApplicationController
  before_action :require_login
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  def autocomplete
    query = params[:query].to_s.strip
    return render json: [] if query.blank?

    Rails.logger.debug "検索ワード: #{query}"

    # 検索ワードの前後に%を付けたクエリを定義
    wildcard_query = "%#{query}%"

    # キーワード候補を取得（アイテム名と投稿タイトルを対象）
    keyword_results = KitItem.where("name ILIKE ?", wildcard_query).distinct.limit(5).pluck(:name)
    board_results = Board.where("title ILIKE ?", wildcard_query).distinct.limit(5).pluck(:title)

    # キーワードをユニークにしてJSONで返す
    suggestions = (keyword_results + board_results).uniq.first(10)

    Rails.logger.debug "検索候補: #{suggestions}"

    render json: suggestions
  end

  def index
    @boards = Board.left_joins(emergency_kits: :kit_items).distinct
  
    # フリーワード検索
    if params[:search].present?
      query = "%#{params[:search]}%"
      @boards = @boards.where('boards.title ILIKE :query OR boards.description ILIKE :query OR kit_items.name ILIKE :query', query: query)
    end
  
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

  def show
    @emergency_kits = @board.emergency_kits
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
