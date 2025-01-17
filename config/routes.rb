Rails.application.routes.draw do
  root 'static_pages#top'
  get 'sessions/new'
  get 'static_pages/top', to: 'static_pages#top', as: 'static_pages_top'
  get 'static_pages/welcome', to: 'static_pages#welcome'
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  # Session用のルートティングを設定
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
