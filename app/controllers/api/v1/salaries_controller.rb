class Api::V1::SalariesController < ApplicationController
  def city_salaries
    if params[:destination]
      @facade = SalariesFacade.new(params).destination_salaries
      render json: @facade, status: 200
    else
      render json: ErrorSerializer.bad_request, status: 400
    end
  end
end
