Sm::Application.routes.draw do
  devise_for :users
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

  resources :users  do
    resources :profiles
    member do
      get :following, :followers
    end
  end

  get '/profile/:username', to: 'users#show'#, as: :user do
  # member do
  #  get :following, :followers
  # end
  # end

  resources :relationships, only: [:create, :destroy]

  resources :messages
end
