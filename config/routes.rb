Rails.application.routes.draw do
  devise_for :users
  resources :entries do
    resources :comments
  end
  root 'entries#index'

  get '/list', to: "entries#list"

  namespace :api do
    resources :entries, path: 'news' do
      resources :comments
    end
  end

end
