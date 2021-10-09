Rails.application.routes.draw do
  root 'html_pages#home'
  get '/help', to: 'html_pages#help' # html_pages#help is the controller and the action. we are mapping the url /help to that controller and action
  get '/about', to: 'html_pages#about'
  get '/contact', to: 'html_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', 
  resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

