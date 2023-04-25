Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get '/forecast', to: 'forecasts#city_weather'

      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resources :road_trip , only: [:create]
    end
  end

end
