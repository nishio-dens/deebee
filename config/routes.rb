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
    resources :translations, only: [:index]
    resources :imports, only: [:index, :create] do
      post :confirm, on: :collection
    end
    resources :exports, only: [:index]
  end

  namespace :api, defaults: { format: :json } do
    resources :projects do
      resources :translations
    end
  end
end
