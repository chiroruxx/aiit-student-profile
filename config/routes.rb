# frozen_string_literal: true

Rails.application.routes.draw do
  get 'register', to: 'user_profiles#new'
  resources :user_profiles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  %w[400 404 500].each do |code|
    get code, to: 'errors#show', code: code
  end
end
