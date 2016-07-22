Rails.application.routes.draw do
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  get "sessions/new"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users, except: [:destroy]

  resources :categories
  resources :categories do
    resources :lessons, except: [:index, :destroy, :edit]
  end

  resources :lessons, except: [:edit, :destroy]
  # resources :relationships, only: [:create, :destroy]
  resources :categories
  resources :words, only: :index

  namespace :admin do
    root "users#index"
    resources :users, only: [:index, :destroy]
    resources :words, only: [:index]
    resources :categories do
      resources :words, only:[:new, :create]
    end
  end
end
