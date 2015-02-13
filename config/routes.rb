SJYABackOffice::Application.routes.draw do
  resources :organizations

  resources :users do
    member do
      post 'invite', to: 'invites#create', as: :invite
      delete 'uninvite', to: 'invites#destroy', as: :uninvite
      get 'register/:invite_code', to: 'invites#edit', as: :rsvp
      match 'register', to: 'invites#update', via: [:patch, :put], as: :register
      match 'revoke', to: 'users#revoke', via: [:patch, :put], as: :revoke
    end
  end

  resources :documents do
    get 'download', on: :member, as: :download
  end

  resources :measures, except: [:show] do
    resources :measurements, except: [:index, :show]
  end
  get 'dashboard', to: 'measures#index', as: :dashboard

  resources :reports, only: [:index, :show]

  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get 'cache/clear', to: 'cache#clear', as: :clear_caches

  get 'about', to: 'static_pages#about', as: :about
  get 'login', to: 'sessions#new', as: :login
  delete 'logout', to: 'sessions#destroy', as: :logout


  get 'reports', to: 'static_pages#reports', as: :reports
  get 'activity_summary', to: 'static_pages#activity_summary', as: :activity_summary
  get 'coalition_report', to: 'static_pages#coalition_report', as: :coalition_report
  get 'coalition_meeting_report', to: 'static_pages#coalition_meeting_report', as: :coalition_meeting_report
  get 'major_matrix_report', to: 'static_pages#major_matrix_report', as: :major_matrix_report
  get 'strategy_report', to: 'static_pages#strategy_report', as: :strategy_report

  mount Rapidfire::Engine => "/rf"

  root to: 'measures#index'
end
