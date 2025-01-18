Rails.application.routes.draw do
  # ログイン状態に応じてトップページを動的に変更
  root to: redirect { |path, req| req.session[:user_id].present? ? '/static_pages/top' : '/welcome' }

  # ユーザー登録用ページ
  get 'welcome', to: 'static_pages#welcome'
  get 'static_pages/top', to: 'static_pages#top', as: 'static_pages_top'

  # 他のルーティング設定
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  # ログイン関連のルーティング
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :destroy_user_session

  # セッションのルーティングを追加
  resource :session, only: [:new, :create, :destroy]
end
