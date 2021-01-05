Rails.application.routes.draw do
  passwordless_for :users

  get '/register' => 'users#new', as: 'register'
  get '/people' => "users#index"

  resources :users, only: [:create, :update, :edit]
  get '/settings', to: "users#edit", :as => "settings"

  get '/contact' => "site#contact"
  get '/about' => "site#about"

  get '/stories', to: redirect('/posts')


  root :to => "site#home"

  get "refresh"  => "posts#refreshposts", :as => "refresh"

  resources :posts do
    resources :comments
  end

  scope ':username' do
    resources :posts
  end

  resources :relationships, only: [:create, :destroy]

  resources :messages

  get '/:username', to: 'users#show'

end
