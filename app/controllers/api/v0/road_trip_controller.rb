class Api::V0::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:api_key])
      @facade = RoadTripFacade.new(params).trip_info
    else
      render json: ErrorSerializer.unauthorized, status: 401
    end
  end
end
