Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get    '/signup',  to: 'students#new'
  post   '/signup',  to: 'students#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'

  resources :students, only: [:show, :new, :create, :edit, :update]

  resources :students, only: [:show] do
    resources :assignments
    resources :courses
  end

  root 'welcome#home'
end
