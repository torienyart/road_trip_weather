class RoadTripFacade
  def initialize(params)
    @start_city = params[:origin]
    @end_city = params[:destination]
  end

  def trip_info
    info_hash = {
      start_city: @start_city,
      end_city: @end_city,
      travel_time: travel_time,
      weather_at_eta: eta_weather_info
    }
    RoadTrip.new(info_hash)
  end

  def travel_time_in_seconds
    response = MapService.travel_time(@start_city, @end_city)
    response[:time][1]
  end

  def travel_time
    if travel_time_in_seconds == 0
      "impossible route"
    else
      formatted_travel_time(travel_time_in_seconds)
    end
  end

  def formatted_travel_time(travel_time)
    seconds = travel_time
    hours = seconds / 3600
    seconds %= 3600
    minutes = seconds / 60
    seconds %= 60
    format('%02d:%02d:%02d', hours, minutes, seconds)
  end

  def eta_weather_info
    if travel_time == "impossible route"
      {}
    else
      estimated_arrival_time = Time.now + travel_time_in_seconds
      params = {}
      params[:location] = @end_city
      day_index = estimated_arrival_time.day - Time.now.day
      forecast_array = ForecastsFacade.new(params).eta_hourly_weather(location_latlng, day_index)
      forecast_array.find do |hour_weather|
        hour_weather[:datetime] == estimated_arrival_time.strftime("%Y-%m-%d %H:00")
      end
    end
  end

  def location_latlng
    WeatherService.location_weather(@end_city)
  end
end