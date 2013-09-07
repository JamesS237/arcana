Arcana::Application.routes.draw do
  get "static_pages/home"
  get "static_pages/about"
  match '/signup',     to: 'students#new',            via: 'get'
  match '/signin',    to: 'sessions#new',         via: 'get'
  resources :students
  resources :assessments
  resources :results
  resources :subjects
  resources :types
  resources :sessions, only: [:new, :create, :destroy]
  
  root 'static_pages#home'
end
