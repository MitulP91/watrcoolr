Watrcoolr::Application.routes.draw do
  # devise for routes
  devise_for :users

  # root url
  root :to => 'home#index'
end
