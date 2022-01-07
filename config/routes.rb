# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'sign_out', to: 'sessions#destroy', as: 'sign_out'

  resources :sessions, only: %i[create destroy]

  get '/register', to: 'user_profiles#new'
  resources :user_profiles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
