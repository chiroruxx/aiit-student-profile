# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'sign_out', to: 'sessions#destroy', as: 'sign_out'

  resources :sessions, only: %i[create destroy]

  get 'profiles/edit', to: 'user_profiles#edit'
  match 'profiles', to: 'user_profiles#update', via: %i[post patch]

  resources :user_profiles, path: :profiles, as: :profiles, only: %i[index show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  %w[400 404 500].each do |code|
    get code, to: 'errors#show', code: code
  end
end
