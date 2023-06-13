Rails.application.routes.draw do
  get "static_pages/home"
  get "static_pages/about"
  scope "(:locale)", locale: /en|vi/ do
    resources :users, only: %i(new create show)
    resources :articles
    get "/", to: "welcome#index"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"

    delete "/logout", to: "sessions#destroy"
    root "welcome#index"
  end
end
