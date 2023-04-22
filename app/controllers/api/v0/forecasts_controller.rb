class Api::V0::ForecastsController < ApplicationController
  def city_weather
    @facade = ForecastsFacade.city_weather(params[:location])
  end
end