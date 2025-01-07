Rails.application.routes.draw do
  root "root#index"

  devise_for :users

  resources :users, only: [:show]

  resources :jobs do
    member do
      post 'apply'
    end
  end
end
