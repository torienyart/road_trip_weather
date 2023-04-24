Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get '/forecast', to: 'forecasts#city_weather'
    end

    namespace :v1 do
      get '/salaries', to: 'salaries#city_salaries'
    end
  end

end
