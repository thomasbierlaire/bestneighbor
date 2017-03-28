Rails.application.routes.draw do
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/team" => "pages#team"
  get "/contact" => "pages#contact"

  get "/users" => "users#index"
  get "/articles" => "articles#index"
  get "/lists" => "lists#index"
  get "/shops" => "shops#index"

end
