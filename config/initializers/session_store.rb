# config/initializers/session_store.rb
Rails.application.config.session_store :cookie_store,
  key: '_stock_supporter_session',
  domain: Rails.env.production? ? '.stock-supporter2025.com' : nil,
  same_site: Rails.env.production? ? :none : :lax,
  secure: Rails.env.production?
  