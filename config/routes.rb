Rails.application.routes.draw do
  # ログイン状態に応じてトップページを動的に変更
  root to: redirect { |path, req| req.session[:user_id].present? ? '/static_pages/top' : '/welcome' }

  # ユーザー登録
  get 'welcome', to: 'static_pages#welcome'
  get 'static_pages/top', to: 'static_pages#top', as: 'static_pages_top'
  
  # 他ルーティング
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  # ログイン関連
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete 'logout', to: 'sessions#destroy', as: 'destroy_user_session'

  # ストック関連
  namespace :stocks do
    resources :stocks
    resources :emergency_kits do
      resources :kit_items, only: [:create, :new, :index]  # kit_itemsのリソースを追加
      collection do
        get 'all'  # 'stocks/emergency_kits/all' のパスを設定
      end
    end
  end
end
