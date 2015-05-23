Rails.application.routes.draw do
  root to: 'projects#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy"
  end

  resources :projects, only: [:index] do
  end

  namespace :api, defaults: { format: :json } do
  end
end
