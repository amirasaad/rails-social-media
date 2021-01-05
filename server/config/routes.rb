Rails.application.routes.draw do
  passwordless_for :users

  get '/register' => 'users#new', as: 'register'
  resources :users, only: [:create]
  get '/contact' => "site#contact"
  get '/about' => "site#about"
  get '/people' => "users#index"

  get '/settings' => "profiles#edit", :as => "settings"

  get '/stories', to: redirect('/posts')


  root :to => "site#home"

  get  "refresh"  => "posts#refreshposts", :as => "refresh"

  resources :posts do
    resources :comments
  end

  scope ':username' do
    resources :posts
  end

  resources :profiles, only: [:update, :create]
  get '/:username', to: 'users#show'#, as: :user do
  # member do
  #  get :following, :followers
  # end
  # end

  resources :relationships, only: [:create, :destroy]

  resources :messages
end
