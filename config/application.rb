require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # デフォルトのロケールを日本語に設定
    config.i18n.default_locale = :ja
    config.i18n.available_locales = [:ja, :en]  # 必要に応じて、利用するロケールを指定

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
  end
end
