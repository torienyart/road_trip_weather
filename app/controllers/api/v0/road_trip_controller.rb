class Api::V0::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:api_key])
      @facade = RoadTripFacade.new(params).trip_info
      render json: @facade, status: 200

    else
      render json: ErrorSerializer.unauthorized, status: 401
    end
  end
end
