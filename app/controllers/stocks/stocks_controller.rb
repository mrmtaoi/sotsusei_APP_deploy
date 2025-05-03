class Stocks::StocksController < ApplicationController
  before_action :require_login
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  def index
    @stocks = current_user.stocks
    @stock_items = StockItem.joins(:stock).where(stocks: { user: current_user })

    # カテゴリーごとの必要量（仮のデータ）
    required_quantities = {
      "食料" => 21, "飲料" => 21, "医療・衛生用品" => 3,
      "防寒具" => 1, "寝具" => 1, "衣類" => 1,
      "乾電池" => 5, "ライト" => 1, "ラジオ" => 1,
      "スマホ充電機器" => 1, "トイレ用品" => 10, "貴重品・身分証明書関係" => 2, "その他" => 2
    }

    # アドバイスメッセージ（不足時の提案）
    advice_messages = {
      "食料" => "食料が不足しているかもしれません。1週間分の食事は備えておきたいです。",
      "飲料" => "水が不足しているかもしれません。1週間分の飲料は備えておきたいです。",
      "医療・衛生用品" => "応急処置セットが足りない可能性があります。救急セットや歯ブラシ、生理用品などを準備しましょう。",
      "防寒具" => "寒さ対策が不十分かもしれません。アルミシートやカイロ、雨具などを追加しましょう。",
      "寝具" => "寝具が不足しているようです。簡易マットや寝袋などを用意しておきましょう。",
      "衣類" => "着替えの用意は十分ですか？下着や靴下も含めて、季節に合ったものを備えましょう",
      "乾電池" => "電池が足りないかもしれません。ラジオや懐中電灯のために備えておきましょう。",
      "ライト" => "夜間の行動を考え、懐中電灯やランタンを追加しましょう。",
      "ラジオ" => "情報収集用のラジオを準備しましょう。電池式や手回し式など停電時にも使えるものが便利です。",
      "スマホ充電機器" => "スマホ充電機器が不足しています。モバイルバッテリーやソーラー充電器などを準備しましょう。",
      "トイレ用品" => "トイレ用品が不足しているかもしれません。非常用トイレや備蓄用トイレットペーパーなどを備えましょう。",
      "貴重品・身分証明書関係" => "貴重品・身分証明書関係が不足しているかもしれません。現金や身分証のコピーなどを備えましょう。",
      "その他" => "その他の必要なアイテムはありませんか。眼鏡や爪切り、哺乳瓶など、自分や家族の必需品を準備しておきましょう。"
    }

    # 現在のバッグ内のアイテム数を集計
    current_quantities = @stock_items.group(:category_id).sum(:quantity)

    # 不足アイテムの計算
    @missing_items = required_quantities.filter_map do |category_name, required_quantity|
      category = Category.find_by(name: category_name)
      next unless category

      current_quantity = current_quantities[category.id] || 0
      missing = [required_quantity - current_quantity, 0].max

      next unless missing.positive?

      {
        name: category_name,
        missing: missing,
        advice: advice_messages[category_name]
      }
    end

    # 各カテゴリーの進捗度を計算
    @category_progress = required_quantities.filter_map do |category_name, required_quantity|
      category = Category.find_by(name: category_name)
      next unless category

      current_quantity = current_quantities[category.id] || 0
      progress = [current_quantity.to_f / required_quantity * 100, 100].min # 100%を上限に設定

      {
        name: category_name,
        progress: progress,
        missing: [required_quantity - current_quantity, 0].max, # 不足分を計算
        advice: advice_messages[category_name]
      }
    end

    # グラフ用データの作成
    @chart_data = @category_progress.map do |category|
      { name: category[:name], progress: category[:progress] }
    end.to_json
  end

  def new
    @stock = Stock.new
    # stock_items と reminders をビルド
    @stock.stock_items.build.reminders.build
  end

  def edit
    @stock = Stock.find(params[:id])
    # stock_items と reminders がすでに存在していない場合のみビルド
    @stock.stock_items.build if @stock.stock_items.empty?
    @stock.stock_items.each do |stock_item|
      stock_item.reminders.build if stock_item.reminders.empty?
    end
  end

  def create
    @stock = Stock.new(stock_params)
    @stock.user = current_user

    # リマインダーに user_id を設定
    @stock.stock_items.each do |stock_item|
      stock_item.reminders.each do |reminder|
        reminder.user = current_user if reminder.user.nil?
      end
    end

    if @stock.save
      redirect_to stocks_stocks_path, notice: '備蓄アイテムが登録されました。'
    else
      Rails.logger.debug @stock.errors.full_messages # デバッグ用: エラー内容をログに出力
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @stock.assign_attributes(stock_params)

    # stock_items の reminder に user を設定
    @stock.stock_items.each do |stock_item|
      stock_item.reminders.each do |reminder|
        reminder.user = current_user if reminder.user.nil? # user を設定
      end
    end

    if @stock.save
      redirect_to stocks_stocks_path, notice: '備蓄アイテムが更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @stock.destroy
    redirect_to stocks_stocks_path, notice: 'Stock was successfully destroyed.'
  end

  private

  def stock_params
    params.require(:stock).permit(
      :body,
      stock_items_attributes: [
        :id, :name, :category_id, :quantity, :storage, :_destroy,
        { reminders_attributes: [:id, :expiration_date, :interval_months, :_destroy] }
      ]
    )
  end

  def set_stock
    @stock = Stock.find(params[:id])
  end
end
