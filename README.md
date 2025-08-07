⛑️ プロジェクト名：『ストックサポーター』

📑 目次

🧭 サービス概要

家族構成に応じた防災備蓄の管理・通知・共有ができるアプリです。
家族構成に合わせた個別の備蓄管理
消費期限・定期確認タイミングの通知機能
備蓄リストの投稿・共有・閲覧が可能


🌐 サービスURL

[https://stock-supporter2025.com](https://stock-supporter2025.com)

💡 サービス開発の背景

防災士の資格を取得し、防災用品を扱う職場での経験を通じて、防災備蓄の重要性とその管理の難しさを実感しました。
備蓄はしていても "買って満足" で放置しがち
期限切れや動作しないアイテムが多く、いざという時に使えない危険
ユーザー同士の情報共有で、備えの質向上やもれ防止に繋げたい
このような課題を解決し、防災意識を高める手助けとなるアプリを目指しました。


✅ 実装機能

・認証・ログイン機能
・家族構成員ごとの備蓄品登録・管理機能
・消費期限や定期確認日などの期日設定機能
・期日通知メール送信
・現在の備蓄一覧のURL生成
・防災備蓄の掲示板機能（投稿・閲覧・検索）
・備蓄品の提案機能
・楽天・Amazon検索機能（必要な備蓄品の購入をサポート）


🔧 技術構成
サーバーサイド
　Ruby on Rails 7.0.x

フロントエンド
　HTML / CSS / JavaScript / Stimulus

CSSフレームワーク
　Tailwind CSS

データベース
　PostgreSQL

通知機能
　ActionMailer / Whenever Gem

外部API連携
　楽天商品検索API / Amazon Product Advertising API

バージョン管理
　GitHub

デプロイ
　Docker + Render


🧾 使用技術
| カテゴリ            | 使用技術・ライブラリ                                                                       |
| --------------- | -------------------------------------------------------------------------------- |
| **サーバーサイド**     | Ruby 3.1.2 / Ruby on Rails 7.0.8.7                                               |
| **データベース**      | PostgreSQL (`pg`)                                                                |
| **フロントエンド**     | Importmap / Turbo / Stimulus / Bootstrap 5 / jQuery                              |
| **CSSプリプロセッサ**  | Sass (`sassc`, `sassc-rails`)                                                    |
| **ビュー関連**       | Jbuilder / Sprockets                                                             |
| **ユーザー認証**      | Omniauth / Omniauth Google OAuth2 / BCrypt                                       |
| **検索機能**        | Ransack                                                                          |
| **外部API連携**     | Rakuten Web Service API / SendGrid API                                           |
| **環境変数管理**      | Dotenv                                                                           |
| **スケジュール管理**    | Whenever                                                                         |
| **SEO対応**       | Sitemap Generator                                                                |
| **デバッグ / 開発支援** | Web Console / Spring / Letter Opener Web / Debug / Capybara / RSpec など           |
| **テスト**         | RSpec / FactoryBot / Capybara / Selenium / Webdrivers / Rails Controller Testing |
| **静的解析 / リンター** | Rubocop / Rubocop Rails / Rubocop RSpec / Rubocop Performance                    |
| **国際化対応**       | Rails i18n（多言語対応）                                                                |
| **その他**         | Faker（テストデータ生成） / TZInfo / JSON / Rake                                           |


🗺️ ER図

（図を挿入予定）

🔄 画面遷移図

（図を挿入予定）
