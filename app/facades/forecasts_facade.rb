class ForecastsFacade
  def initialize(params)
    @city = params[:location]
  end

  def city_weather
    response = WeatherService.location_weather(latlng_for_city)
    city_weather_serializer(response)
  end

  def city_weather_serializer(response)
    c = current_weather(response)
    d = daily_weather(response)
    h = hourly_weather(response)
    CityWeatherSerializer.serialized_forecast(c, d, h)
  end

  def current_weather(response)
    poro = CurrentWeather.new(response[:current])
  end

  def daily_weather(forecastday)
    poros = forecastday[:forecast][:forecastday].map do |day_data|
      DayWeather.new(day_data)
    end
  end

  def hourly_weather(hourly_data)
    poros = hourly_data[:forecast][:forecastday][0][:hour].map do |hour_data|
      HourWeather.new(hour_data)
    end
  end

  def eta_hourly_weather(hourly_data, day_index)
    poros = hourly_data[:forecast][:forecastday][day_index][:hour].map do |hour_data|
      HourWeather.new(hour_data)
    end
  end

  def latlng_for_city
    response = GeocodingService.latlng_for_city(@city)
    latlng_hash = response[:results][0][:locations][0][:latLng]
    latlng_hash.values.join(", ")
  end
end