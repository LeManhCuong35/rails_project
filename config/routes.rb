Rails.application.routes.draw do
  get "static_pages/home"
  get "static_pages/about"
  scope "(:locale)", locale: /en|vi/ do
    resources :users
    resources :articles
    get "/", to: "welcome#index"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"

    delete "/logout", to: "sessions#destroy"
    root "welcome#index"

    resources :account_activations, only: :edit

    resources :password_resets, only: %i(new create edit update)

    resources :users do
      member do
        get :following, :followers
      end
    end

    resources :relationships, only: %i(create destroy)
  end
end
