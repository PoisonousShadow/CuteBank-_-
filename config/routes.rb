# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :main, only: [:index]

  resources :about, only: [:index]

  resources :admin, only: %i[index create]

  resources :user, only: %i[index create]

  root to: 'main#index'
end
