class Api::V0::ForecastsController < ApplicationController
  def city_weather
    if params[:location]
      @facade = ForecastsFacade.new(params).city_weather
      render json: ForecastSerializer.new(@facade), status: 200
    else
      render json: ErrorSerializer.bad_request, status: 400
    end
  end
end