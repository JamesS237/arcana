Arcana::Application.routes.draw do
  root 'static_pages#home'

  match '/results', to: 'results#update', via: 'put'
  match '/results', to: 'results#create', via: 'post'
  match '/:name/results', to: 'results#user', via: 'get', as: :student_results
  match '/results/:id', to: 'results#update', via: 'post'

  match '/about',     to: 'static_pages#about',            via: 'get'
  match '/legal',     to: 'static_pages#legal',            via: 'get'
  
  match '/signup',     to: 'students#new',            via: 'get'
  match '/signin',    to: 'sessions#new',         via: 'get'
  match '/signout',    to: 'sessions#destroy',         via: 'get'

  match '/assessments/subject/:name', to: 'assessments#index', via: 'get'
  match '/search', to: 'static_pages#search', via: 'get'

  resources :students
  resources :assessments
  resources :results
  resources :subjects
  resources :types
  resources :sessions, only: [:new, :create, :destroy]
end
