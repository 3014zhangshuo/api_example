Rails.application.routes.draw do
  devise_for :users
  root "welcome#index"

  resources :cities do
    member do
      post :update_temp
    end
  end

  namespace :api, :defaults => { :format => :json } do
    namespace :v1 do
      get "/me" => "users#show", as: :user
      patch "/me" => "user#update", as: :update_user

      post "/signup" => "auth#signup"
      post "/login" => "auth#login"
      post "/logout" => "auth#logout"

      get "/reservations" => "reservations#index", as: :reservations

      resources :trains, :only => [:index, :show]
      resources :reservations, :ony => [:show, :create, :update, :destroy]
    end
  end

end
