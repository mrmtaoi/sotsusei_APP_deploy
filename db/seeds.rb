# 既存データの削除（削除順に注意）
Reminder.delete_all  # まず reminders を削除
KitItem.delete_all   # 次に kit_items を削除
Category.delete_all  # 最後に categories を削除

# カテゴリーの登録
allowed_categories = ["食料", "飲料", "医療・衛生用品", "防寒具", "寝具", "衣類", "乾電池", "ライト", "ラジオ", "スマホ充電機器", "トイレ用品", "貴重品・身分証明書関係", "その他"]

# 新しいカテゴリの作成（重複しないようにする）
allowed_categories.each do |category|
  Category.find_or_create_by!(name: category)
end
