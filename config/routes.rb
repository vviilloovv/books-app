# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)" do
    resources :books
    devise_for :users, controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions",
    }
  end
  root to: "books#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
