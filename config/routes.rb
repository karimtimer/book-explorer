# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get "uploads/new"
  get "uploads/create"
  get "uploads/index"
  get "uploads/show"
  resources :uploads
  root "pages#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
