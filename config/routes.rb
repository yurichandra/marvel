Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "/users/follow", to: "users#follow"
  post "/users/unfollow", to: "users#unfollow"
end
