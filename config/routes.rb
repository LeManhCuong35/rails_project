Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/about'
  scope "(:locale)", locale: /en|vi/ do
    resources :users
    resources :articles
    get '/', to: 'welcome#index'
  end
end
