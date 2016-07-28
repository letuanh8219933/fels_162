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
  resources :categories, only: [:index]
  resources :lessons, only: [:create, :show, :update]
  resources :words, only: [:index]
  namespace :admin do
    root "users#index"
    resources :users, only: [:index, :destroy]
    resources :words, only: [:index]
    resources :categories do
      resources :words, only:[:new, :create]
    end
  end
  resources :relationships, only: [:create, :destroy, :index]
  resources :users do
    get "/:relationship", on: :member,
      to: "relationships#index", as: :relationships
  end
end

