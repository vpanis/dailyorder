Rails.application.routes.draw do
  require "sidekiq/web"

  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users,
    controllers: {
      registrations: "users/registrations",
      omniauth_callbacks: 'users/omniauth_callbacks'
    }

  mount Attachinary::Engine => "/attachinary"

  scope '(:locale)', locale: /fr/ do

    root to: 'pages#home'

    resources :products, :only => [:index]

    resources :restaurants do
      resources :profiles, only: [:index, :new, :create, :edit, :update]
      resources :suppliers, only: [:index]
      resources :relations, only: [:index, :new, :create, :edit, :update, :destroy]
      resources :orders, only: [:new, :create, :edit, :update, :destroy]
      get "index_pending" => "orders#index_pending"
      get "index_validated" => "orders#index_validated"
      get "index_sent" => "orders#index_sent"
      resources :documents, only: [:show]
    end

    resources :suppliers do
      resources :relations
      resources :documents
      resources :products
    end
  end
end
