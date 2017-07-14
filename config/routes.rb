Rails.application.routes.draw do

  devise_for :users,
    controllers: {
      registrations: "users/registrations",
      omniauth_callbacks: 'users/omniauth_callbacks'
    }

  mount Attachinary::Engine => "/attachinary"

  scope '(:locale)', locale: /fr/ do
    root to: 'pages#home'

    resources :profiles

    resources :products, :only => [:index] do
      collection do
        get :autocomplete
      end
    end

    resources :restaurants do
      resources :relations, only: [:index]
      get "index_pending" => "orders#index_pending"
      get "index_validated" => "orders#index_validated"
      get "index_sent" => "orders#index_sent"
      resources :orders, only: [:new, :create, :edit, :update, :destroy]
      resources :documents, only: [:show]
    end

    resources :suppliers do
      resources :relations
      resources :documents
      resources :products
    end
  end
end
