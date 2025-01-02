Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "/api/users/follow", to: "users#follow"
  post "/api/users/unfollow", to: "users#unfollow"
end
