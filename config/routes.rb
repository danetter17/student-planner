Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get    '/signup',  to: 'students#new'
  post   '/signup',  to: 'students#create'
  patch   '/signup',  to: 'students#update'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'
  get '/auth/:provider/callback' => 'sessions#omniauth'

  resources :students, except: [:index]

  resources :students, only: [:show] do
    resources :assignments
    resources :courses
  end

  root 'welcome#home'
end
