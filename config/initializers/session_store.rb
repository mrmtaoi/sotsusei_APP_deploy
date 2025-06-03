# config/initializers/session_store.rb
Rails.application.config.session_store :cookie_store,
  key: '_stock_supporter_session',
  same_site: :none,      # ← Google認証後のリダイレクト対応に必要
  secure: true           # ← HTTPSが必須（Render本番環境はOK）
