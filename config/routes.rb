Rails.application.routes.draw do
  root to: 'schemata#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy"
  end

  resources :projects, only: [:index] do
    resources :schemata
  end

  namespace :api, defaults: { format: :json } do
    resources :projects, only: [] do
      resources :tables, only: [:index, :show]
      resources :columns, only: [:update]
      resources :divisions, only: [:index]
    end
  end
end
