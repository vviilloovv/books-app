# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
  }
  scope "(:locale)" do
    resources :books
    resources :reports
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions",
    }
    resources :users, only: [:index, :show]
    resources :followings, only: [:create, :destroy]
    resources :comments, only: [:index, :edit, :create, :update, :destroy]
  end
  root to: "books#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
