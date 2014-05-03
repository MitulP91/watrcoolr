Watrcoolr::Application.routes.draw do
  # devise for routes
  devise_for :users

  # Room routes
  resources :rooms, only: :index do
    collection { get :events }
  end
  get '/rooms/:id', to: "rooms#watrcoolr", as: "room"
  post '/rooms/add_message', to: 'rooms#add_message'


  # messages routes
  resources :messages
  resources :texts, controller: 'messages', type: 'Text' 
  resources :videos, controller: 'messages', type: 'Video' 
  resources :images, controller: 'messages', type: 'Image'

  # root url
  root :to => 'home#index'
end
