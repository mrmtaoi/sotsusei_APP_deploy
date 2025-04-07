Rails.application.routes.draw do
 # ログイン状態に応じてトップページを動的に変更
  root to: redirect { |path, req| req.session[:user_id].present? ? '/static_pages/top' : '/welcome' }

  # ユーザー登録
  get 'welcome', to: 'static_pages#welcome'
  get 'static_pages/top', to: 'static_pages#top', as: 'static_pages_top'
  
  # 他ルーティング
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :edit, :update, :destroy, :new, :create]
  resources :boards, only: [:index, :show, :new, :create, :edit, :destroy] do
    collection do
      get :autocomplete
    end
  end
  get 'items/search'

  # ログイン関連
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete 'logout', to: 'sessions#destroy', as: 'destroy_user_session'

  # ストック関連
  namespace :stocks do
    resources :stocks, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :emergency_kits, only: [:index, :show, :create, :edit, :update, :destroy, :new] do
      collection do
        get 'all'
      end
      resources :kit_items, only: [:index, :create, :edit, :update, :destroy] do
      end
    end
  end  
end
