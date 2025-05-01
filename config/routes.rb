# config/routes.rb

Rails.application.routes.draw do
  # ログイン状態に応じてトップページを動的に変更
  root to: redirect { |path, req| req.session[:user_id].present? ? '/static_pages/top' : '/welcome' }

  # ユーザー登録
  get 'welcome', to: 'static_pages#welcome'
  get 'static_pages/top', to: 'static_pages#top', as: 'static_pages_top'
  get 'account_activations/:activation_token/edit', to: 'account_activations#edit', as: 'account_activation'


  # 他ルーティング
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :edit, :update, :destroy, :new, :create]
  resources :boards, only: [:index, :show, :new, :create, :edit, :destroy] do
    collection do
      get :autocomplete
    end
  end
  get 'items/search'
  get "shared/:token", to: "stocks/emergency_kits#shared", as: :shared_emergency_kit
  get 'terms', to: 'static_pages#terms'
  get 'privacy_policy', to: 'static_pages#privacy_policy'

  # ログイン関連
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete 'logout', to: 'sessions#destroy', as: 'destroy_user_session'
  # Google OAuth2のコールバックルート
  get '/auth/google_oauth2/callback', to: 'sessions#google_auth'
  get '/auth/failure', to: redirect('/')  # 認証失敗時のリダイレクト先

  # ストック関連
  namespace :stocks do
    resources :stocks, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :emergency_kits, only: [:index, :show, :create, :edit, :update, :destroy, :new] do
      collection do
        get 'all'
      end
      resources :kit_items, only: [:index, :create, :edit, :update, :destroy]
    end
  end

  namespace :internal do
    post 'send_reminders', to: 'reminders#deliver'
  end

  # LetterOpenerWeb のルーティング（開発環境限定）
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end  
end
