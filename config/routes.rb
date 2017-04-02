Rails.application.routes.draw do
  root to: 'pages#home'
  get "/aide" => "pages#aide"
  get "/contact" => "pages#contact"
  get "/choix" => "pages#choix"

  resources :users
  resources :listes
  resources :articles

end
