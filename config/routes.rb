Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        resources :posts, only: [:index, :show] do
          resources :comments, only: [:index, :create, :new, :destroy]
          resources :likes, only: [:create, :new]
        end
      end
    end
  end


  root "users#index"
  resources :users do
    resources :posts do
      member do
        get 'api_index'
        get 'api_comments'
        post 'api_add_comment'
      end
    end
  end
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy ] do
      resources :comments, only: [:create, :new, :destroy]
       resources :likes, only: [:create, :new] 
    end
  end
end



