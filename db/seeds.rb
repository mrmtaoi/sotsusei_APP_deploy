# db/seeds.rb
# 保持するカテゴリのリスト
allowed_categories = ["食料", "飲料", "医療・衛生用品", "防寒具", "寝具", "衣類", "乾電池", "ライト", "ラジオ", "スマホ充電機器", "その他"]

# 現在のカテゴリのうち、指定されていないカテゴリを削除
Category.where.not(name: allowed_categories).destroy_all

# 新しいカテゴリの作成（重複しないようにする）
allowed_categories.each do |category|
  Category.find_or_create_by(name: category)
end