class RoadTripFacade
  def initialize(params)
    @start_city = params[:origin]
    @end_city = params[:destination]
  end

  def travel_time
    response = MapService.travel_time(@start_city, @end_city)
    formatted_travel_time(response[:time][1])
  end

  def formatted_travel_time(seconds)
    hours = seconds / 3600
    seconds %= 3600
    minutes = seconds / 60
    seconds %= 60
    format('%02d:%02d:%02d', hours, minutes, seconds)
  end
end