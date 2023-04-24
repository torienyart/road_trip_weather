class ForecastsFacade
  def initialize(params)
    @city = params[:location]
  end

  def city_weather_response
    response = WeatherService.location_weather(latlng_for_city)
  end

  def city_weather
    # response = WeatherService.location_weather(latlng_for_city)
    city_weather_serializer(city_weather_response)
  end

  def city_weather_serializer(response)
    c = current_weather(response[:current])
    d = daily_weather(response[:forecast][:forecastday])
    h = hourly_weather(response[:forecast][:forecastday][0][:hour])
    CityWeatherSerializer.serialized_forecast(c, d, h)
  end

  def current_weather(response)
    poro = CurrentWeather.new(response)
  end

  def daily_weather(forecastday)
    poros = forecastday.map do |day_data|
      DayWeather.new(day_data)
    end
  end

  def hourly_weather(hourly_data)
    poros = hourly_data.map do |hour_data|
      HourWeather.new(hour_data)
    end
  end

  def latlng_for_city
    response = GeocodingService.latlng_for_city(@city)
    latlng_hash = response[:results][0][:locations][0][:latLng]
    latlng_hash.values.join(", ")
  end
end