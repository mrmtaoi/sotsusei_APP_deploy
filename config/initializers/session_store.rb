Rails.application.config.session_store :cookie_store,
  key: '_stock_supporter_session',
  same_site: :lax,
  secure: Rails.env.production?
