# config/initializers/session_store.rb

Rails.application.config.session_store :cookie_store,
  key: '_stock_supporter_session',
  same_site: Rails.env.production? ? :none : :lax,
  secure: Rails.env.production?
