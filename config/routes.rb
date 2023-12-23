Rails.application.routes.draw do
  devise_for :users

  root "users#index"
 
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy ] do
      resources :comments, only: [:create, :new, :destroy]
       resources :likes, only: [:create, :new] 
    end
  end
  get "/posts", to: "posts#user_post"
end



