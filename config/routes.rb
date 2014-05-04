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
  post '/rooms/push_message', to: 'rooms#push_message'
  resources :texts, controller: 'messages', msg_type: 'Text' 
  resources :videos, controller: 'messages', msg_type: 'Video' 
  resources :images, controller: 'messages', msg_type: 'Image'

  # Authenticated Root
  authenticated :user do
    root to: 'home#index', as: :authenticated_root
  end

  # root url
  # root :to => 'home#index'
  root :to => 'home#landing'
end
