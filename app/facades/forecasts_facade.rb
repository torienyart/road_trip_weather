class ForecastsFacade
  def initialize(params)
    @city = params[:location]
  end

  def city_weather
    response = WeatherService.location_weather(latlng_for_city)
    info_hash = {
      current_weather:  current_weather(response[:current]),
      daily_weather: daily_weather(response),
      hourly_weather: hourly_weather(response)
    }
    require 'pry'; binding.pry
    Forecast.new(info_hash)
  end

  def current_weather(response)
    {
    last_updated: response[:last_updated],
    temperature: response[:temp_f],
    feels_like: response[:feelslike_f],
    humidity: response[:humidity],
    uvi: response[:uv],
    visibility: response[:vis_miles],
    condition: response[:condition][:text],
    icon: response[:condition][:icon]
    }
  end

  def daily_weather(response)
    response[:forecast][:forecastday].map do |day_data|
      {
      date: day_data[:date],
      sunrise: day_data[:astro][:sunrise],
      sunset: day_data[:astro][:sunset],
      max_temp: day_data[:day][:maxtemp_f],
      min_temp: day_data[:day][:mintemp_f],
      condition: day_data[:day][:condition][:text],
      icon: day_data[:day][:condition][:icon]
      }
    end
  end

  def hourly_weather(response)
    response[:forecast][:forecastday][0][:hour].map do |hour_data|
      {
      time: hour_data[:time],
      temperature: hour_data[:temp_f],
      condition: hour_data[:condition][:text],
      icon: hour_data[:condition][:icon]
    }
    end
  end

  def eta_hourly_weather(response, day_index)
    response[:forecast][:forecastday][day_index][:hour].map do |hour_data|
      {
      datetime: hour_data[:time],
      temperature: hour_data[:temp_f],
      condition: hour_data[:condition][:text],
      }
    end
    #poros = hourly_data[:forecast][:forecastday][day_index][:hour].map do |hour_data|
    #   HourWeather.new(hour_data)
    # end
  end

  def latlng_for_city
    response = GeocodingService.latlng_for_city(@city)
    latlng_hash = response[:results][0][:locations][0][:latLng]
    latlng_hash.values.join(", ")
  end
end