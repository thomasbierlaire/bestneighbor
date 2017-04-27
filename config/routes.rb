Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'pages#home'
  get "/aide" => "pages#aide"
  get "/contact" => "pages#contact"
  get "/choix" => "pages#choix"
  get "/cgu" => "pages#cgu"
  get "/creerliste" => "pages#creerliste"
  get "/prendreliste" => "pages#prendreliste"
  get "/creertrajet" => "pages#creertrajet"
  get "/prendretrajet" => "pages#prendretrajet"

  resources :listes
  post "/listes/:id" => "listes#takenby"

  resources :trajets
  post "/trajets/:id" => "trajets#takenby"

end
