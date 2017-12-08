Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'pages#home'
  get "/contact" => "pages#contact"
  get "/choix" => "pages#choix"
  get "/courses" => "pages#courses"
  get "/covoit" => "pages#covoit"
  get "/cgu" => "pages#cgu"

  resources :listes
  post "/listes/:id" => "listes#takenby"

  resources :covoiturages
  post "/covoiturages/:id" => "covoiturages#takenby"

end
