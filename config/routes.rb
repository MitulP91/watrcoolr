Watrcoolr::Application.routes.draw do
  # devise for routes
  devise_for :users

  # messages routes
  resources :messages
  resources :texts, controller: 'messages', type: 'Text' 
  resources :videos, controller: 'messages', type: 'Video' 
  resources :images, controller: 'messages', type: 'Image'

  # root url
  root :to => 'home#index'
end
