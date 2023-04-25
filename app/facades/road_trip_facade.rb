class RoadTripFacade
  def initialize(params)
    @start_city = params[:origin]
    @end_city = params[:destination]
  end

  def travel_time
    response = MapService.travel_time(@start_city, @end_city)
    response[:time][1]
  end

  def formatted_travel_time
    seconds = travel_time
    hours = seconds / 3600
    seconds %= 3600
    minutes = seconds / 60
    seconds %= 60
    format('%02d:%02d:%02d', hours, minutes, seconds)
  end

  def eta_weather_info
    estimated_arrival_time = Time.now + travel_time
    if estimated_arrival_time.day == Time.now.day
      weather_later_today(estimated_arrival_time)
    else 
      weather_beyond_today(estimated_arrival_time)
    end
  end

  def location_latlng
    WeatherService.location_weather(@end_city)
  end

  def weather_later_today(estimated_arrival_time)
    params = {}
    params[:location] = @end_city
    forecast_array = ForecastsFacade.new(params).hourly_weather(location_latlng)
    hour_weather = forecast_array.find do |hour_weather|
      hour_weather.time == estimated_arrival_time.strftime("%Y-%m-%d %H:00")
    end
  end

  def weather_beyond_today(estimated_arrival_time)
    params = {}
    params[:location] = @end_city
    day_index = estimated_arrival_time.day - Time.now.day
    forecast_array = ForecastsFacade.new(params).another_day_hourly_weather(location_latlng, day_index)
    forecast_array.find do |hour_weather|
      hour_weather.time == estimated_arrival_time.strftime("%Y-%m-%d %H:00")
    end
  end
end