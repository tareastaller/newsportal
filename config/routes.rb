Rails.application.routes.draw do
  devise_for :users
  resources :entries
  root 'entries#index'

  get '/list', to: "entries#list"
end
