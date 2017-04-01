Rails.application.routes.draw do
  root to: 'pages#home'
  get "/team" => "pages#team"
  get "/contact" => "pages#contact"

  resources :users
  resources :demandeurs, only: [:new, :create, :destroy]
  resources :fournisseurs, only: [:new, :create, :destroy]
  resources :liste_demandeurs, only: [:new, :create, :index, :show, :destroy]
  resources :liste_fournisseurs, only: [:new, :create, :index, :show, :destroy]

end
