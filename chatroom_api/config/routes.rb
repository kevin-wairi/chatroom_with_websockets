Rails.application.routes.draw do
      
      # Authentication routes
      post '/login' , to: 'auth#create'
      resources :chatrooms
      resources :users
      resources :messages


      get "up" => "rails/health#show", as: :rails_health_check

      mount ActionCable.server => "/cable"
end
