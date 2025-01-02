Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    post "/users/follow", to: "users#follow"
    post "/users/unfollow", to: "users#unfollow"

    post "/activities/start", to: "activities#start"
    post "/activities/finish", to: "activities#finish"
    get "/activities/my", to: "activities#my_activities"
    get "/activities/feeds", to: "activities#feeds"
  end
end
