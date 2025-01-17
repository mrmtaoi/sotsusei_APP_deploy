Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  root 'static_pages#top'
  get 'static_pages/top', to: 'static_pages#top', as: 'static_pages_top'
  get 'static_pages/welcome', to: 'static_pages#welcome'
  get 'signup', to: 'users#new'
end
