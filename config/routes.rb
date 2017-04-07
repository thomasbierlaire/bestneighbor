Rails.application.routes.draw do
  root to: 'pages#home'
  get "/aide" => "pages#aide"
  get "/contact" => "pages#contact"
  get "/choix" => "pages#choix"

  get "/users/login" => "users#login"
  post "/users/login" => "users#check"
  delete "/users/login" => "users#logout"
  get "/users/new" => "users#new"
  post "/users" => "users#create"

  resources :listes
  post "/listes/:id" => "listes#takenby"

  resources :articles

end
