Rails.application.routes.draw do

  devise_for :users,
    controllers: {
      registrations: "users/registrations",
      omniauth_callbacks: 'users/omniauth_callbacks'
    }

  mount Attachinary::Engine => "/attachinary"

  scope '(:locale)', locale: /fr/ do
    root to: 'pages#home'

    resources :restaurants do
      resources :relations do
        resources :documents
      end
      resources :orders
    end

    resources :suppliers do
      resources :relations do
        resources :documents
      end
      resources :products
    end
  end
end
