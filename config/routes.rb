SJYABackOffice::Application.routes.draw do
  get "static_pages/about"

  root 'static_pages#about'
end
