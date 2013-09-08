Arcana::Application.routes.draw do
  get "static_pages/home"
  get "static_pages/about"
  match '/results', to: 'results#create', via: 'post'
  match '/signup',     to: 'students#new',            via: 'get'
  match '/about',     to: 'static_pages#about',            via: 'get'
  match '/signin',    to: 'sessions#new',         via: 'get'
  match '/signout',    to: 'sessions#destroy',         via: 'delete'
  match '/:name/results', to: 'results#user', via: 'get', as: :student_results
  
  resources :students
  resources :assessments
  resources :results
  resources :subjects
  resources :types
  resources :sessions, only: [:new, :create, :destroy]
  
  root 'static_pages#home'
end
