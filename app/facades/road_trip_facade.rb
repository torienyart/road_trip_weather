class RoadTripFacade
  def initialize(params)
    @start_city = params[:origin]
    @end_city = params[:destination]
  end

  def travel_time
    MapService.travel_time(@start_city, @end_city)
  end
end