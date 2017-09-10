Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'pages#home'
  get "/aide" => "pages#aide"
  get "/choix" => "pages#choix"
  get "/courses" => "pages#courses"
  get "/covoiturage" => "pages#covoiturage"
  get "/cgu" => "pages#cgu"

  resources :listes
  post "/listes/:id" => "listes#takenby"

  resources :trajets
  post "/trajets/:id" => "trajets#takenby"

end
