Rails.application.routes.draw do
  get 'job_applicants/create'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"
  resources :jobs
  resources :users
  resources :job_applicants, only: [:create]
  get 'jobs', to: 'jobs#index', as: :all_jobs
end
