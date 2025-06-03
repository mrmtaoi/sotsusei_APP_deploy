require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # デフォルトのロケールを日本語に設定
    config.i18n.default_locale = :ja
    config.i18n.available_locales = [:ja, :en] # 必要に応じて、利用するロケールを指定

    config.hosts << 'stock-supporter2025.com'

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.assets.paths << Rails.root.join("app/assets/stylesheets")
    config.assets.enabled = true
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: false, # テストDBにレコードを作るfixtureの作成をスキップ(FactoryBotを使用するため)
                       view_specs: false, # ビューファイル用のスペックを作成しない
                       helper_specs: false, # ヘルパーファイル用のスペックを作成しない
                       routing_specs: false # routes.rb用のスペックファイル作成しない
    end
  end
end
