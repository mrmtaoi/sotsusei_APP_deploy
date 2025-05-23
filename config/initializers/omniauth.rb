# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2,
             ENV['GOOGLE_CLIENT_ID'],
             ENV['GOOGLE_CLIENT_SECRET'],
             scope: 'email,profile',
             redirect_uri: 'https://stock-supporter2025.com/auth/google_oauth2/callback',
             provider_ignores_state: true
  end
  