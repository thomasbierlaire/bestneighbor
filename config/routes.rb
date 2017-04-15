Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'pages#home'
  get "/aide" => "pages#aide"
  get "/contact" => "pages#contact"
  get "/choix" => "pages#choix"

  resources :listes
  post "/listes/:id" => "listes#takenby"

  resources :trajets
  post "/trajets/:id" => "trajets#takenby"

end
