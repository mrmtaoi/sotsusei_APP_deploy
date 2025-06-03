#config/initializers/session_store.rb

Rails.application.config.session_store :cookie_store,
  key: '_stock_supporter_session',
  same_site: :none,
  secure: true # `secure: Rails.env.production?` ではなく常に true に

