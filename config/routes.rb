SJYABackOffice::Application.routes.draw do
  resources :users do
    member do
      post 'invite', to: 'invites#create', as: :invite
      delete 'uninvite', to: 'invites#destroy', as: :uninvite
      get 'register/:invite_code', to: 'invites#edit', as: :rsvp
      match 'register', to: 'invites#update', via: [:patch, :put], as: :register
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  get "static_pages/about"
  get 'login', to: 'sessions#new', as: :login
  delete 'logout', to: 'sessions#destroy', as: :logout

  root 'static_pages#about'
end
