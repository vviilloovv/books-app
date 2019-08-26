# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  scope "(:locale)" do
    resources :books
  end
  root to: "books#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
