Watrcoolr::Application.routes.draw do
  # devise for routes
  devise_for :users

  # Room routes
  resources :rooms, only: [:index, :new] do
    collection { get :events }
  end
  get '/rooms/:id', to: "rooms#watrcoolr", as: "room"
  post '/rooms/add_message', to: 'rooms#add_message'
  post '/rooms/create', to: 'rooms#create'


  # messages routes
  resources :messages
  post '/messages/add_message', to: 'messages#add_message'
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
