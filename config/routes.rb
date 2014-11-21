Sm::Application.routes.draw do
  get '/contact' => "site#contact"
  get '/help' => "site#help"
  get '/about' => "site#about"

  root :to => "site#home"

  get  "refresh"  => "posts#refreshposts", :as => "refresh"

  resources :posts do
    resources :comments
  end

  scope ':username' do
    resources :posts
  end

  get '/stories', to: redirect('/posts')

  resources :users  do
    resources :profiles
    member do
      get :following, :followers
    end
  end
  resource :session, :only => [:new, :create, :destroy]
  get '/login' => "sessions#new", :as => "login"
  get '/logout' => "sessions#destroy", :as => "logout"

  get '/registration' => "users#new"

  get ':username', to: 'users#show'#, as: :user do
   # member do
    #  get :following, :followers
   # end
 # end

  resources :relationships, only: [:create, :destroy]

  resources :messages

end
