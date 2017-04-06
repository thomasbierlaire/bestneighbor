Rails.application.routes.draw do
  root to: 'pages#home'
  get "/aide" => "pages#aide"
  get "/contact" => "pages#contact"
  get "/choix" => "pages#choix"

  get "/users/login" => "users#login"
  post "/users/login" => "users#check"
  get "/users/new" => "users#new"
  post "/users" => "users#create"

  resources :listes
  resources :articles

end
