Rails.application.config.session_store :cookie_store,
  key: '_stock_supporter_session',
  domain: 'stock-supporter2025.com',
  same_site: :lax,
  secure: Rails.env.production?
