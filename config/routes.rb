# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :main

  resources :admin

  resources :user

  get '/users' => 'user#index', as: :user_root # creates user_root_path

  root to: 'main#index'
end
