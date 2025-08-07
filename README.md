⛑️ プロジェクト名：『ぼうさい家族』

📑 目次

サービス概要

サービスURL
stock-supporter2025.com

サービス開発の背景

機能紹介

技術構成について

使用技術

ER図

画面遷移図

🧭 サービス概要

家族構成に応じた防災備蓄の管理・通知・共有ができるアプリです。

家族構成に合わせた個別の備蓄管理

消費期限・定期確認タイミングの通知機能

備蓄リストの投稿・共有・閲覧が可能

🌐 サービスURL

（未定／リリース後に追加予定）

💡 サービス開発の背景

防災士の資格を取得し、防災用品を扱う職場での経験を通じて、防災備蓄の重要性とその管理の難しさを実感しました。

備蓄はしていても "買って満足" で放置しがち

期限切れや動作しないアイテムが多く、いざという時に使えない危険

ユーザー同士の情報共有で、備えの質向上やもれ防止に繋げたい

このような課題を解決し、防災意識を高める手助けとなるアプリを目指しました。

🛠️ 機能紹介

✅ MVPリリースで実装予定の機能

認証・ログイン機能

家族構成員ごとの備蓄品登録・管理機能

消費期限や定期確認日などの期日設定機能

ActionMailer + Whenever による期日通知メール送信

備蓄一覧URL生成と家族・SNSでの共有

🎯 本リリースで実装予定の機能

防災備蓄の掲示板機能（投稿・閲覧・検索）

備蓄品の提案機能（家族構成や季節に応じたアイディアを提示）

楽天・Amazon検索機能（必要な備蓄品の購入をサポート）

🔧 技術構成について

カテゴリ

技術内容

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

楽天商品検索API / Amazon Product Advertising API（予定）

バージョン管理

GitHub（Git Flow）

デプロイ

Docker + Render または Fly.io（予定）

🧾 使用技術

Ruby 3.x

Rails 7.0.x

Tailwind CSS

PostgreSQL

Stimulus（検索補助・フォーム改善）

Docker / Docker Compose

GitHub + Git Flow

ActionMailer / Whenever（通知）

🗺️ ER図

（図を挿入予定）

🔄 画面遷移図

（図を挿入予定）
