# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    ENV['GOOGLE_CLIENT_ID'],
    ENV['GOOGLE_CLIENT_SECRET'],
    {
      scope: 'openid email profile',
      redirect_uri: ENV['GOOGLE_REDIRECT_URI'],
      prompt: 'consent select_account',
      access_type: 'offline',
      provider_ignores_state: false
    }
end
  