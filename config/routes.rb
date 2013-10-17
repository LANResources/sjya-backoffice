SJYABackOffice::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get "static_pages/about"
  match 'login', to: 'sessions#new', via: :get
  match 'logout', to: 'sessions#destroy', via: :delete

  root 'static_pages#about'
end
