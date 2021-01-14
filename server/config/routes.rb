# frozen_string_literal: true

Rails.application.routes.draw do
  passwordless_for :users

  get '/conversations' => 'conversations#index', as: 'conversations'

  resources :conversations, only: [:create] do
    resources :personal_messages, only: [:create]
    member do
      post :close
    end
  end

  get '/register' => 'users#new', as: 'register'
  get '/people' => 'users#index', as: 'people'

  resources :users, only: %i[create update edit destroy]
  get '/settings', to: 'users#edit', as: 'settings'

  get '/contact' => 'site#contact'
  get '/about' => 'site#about'

  get '/stories', to: redirect('/posts')

  root to: 'site#home'

  get 'refresh' => 'posts#refreshposts', :as => 'refresh'

  resources :posts do
    resources :comments
  end

  scope ':username' do
    resources :posts
  end

  resources :relationships, only: %i[create destroy]

  get '/:username', to: 'users#show'
end
