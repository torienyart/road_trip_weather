class CityWeatherSerializer
  def self.serialized_forecast(current_weather, daily_weather, hourly_weather) 
    forecast_hash = {data: {
                       id: "null",
                       type: "forecast",
                       attributes: {
                          current_weather: current_weather_hash(current_weather),
                          daily_weather: daily_weather_array(daily_weather),
                          hourly_weather: hourly_weather_array(hourly_weather)
                       }
    }}
  end

  def self.current_weather_hash(current_weather)
    { 
      last_updated: current_weather.last_updated,
      temperature: current_weather.temperature,
      feels_like: current_weather.feels_like,
      humidity: current_weather.humidity,
      uvi: current_weather.uvi,
      visibility: current_weather.visibility,
      condition: current_weather.condition,
      icon: current_weather.icon
    }
  end

  def self.daily_weather_array(daily_weather)
    daily_weather.map do |weather|
      {
        date: weather.date,
        sunrise: weather.sunrise,
        sunset: weather.sunset,
        max_temp: weather.max_temp,
        min_temp: weather.min_temp,
        condition: weather.condition,
        icon: weather.icon
      }
    end
  end

  def self.hourly_weather_array(hourly_weather)
    hourly_weather.map do |weather|
      {
        time: weather.time,
        temperature: weather.temperature,
        condition: weather.condition,
        icon: weather.icon
      }
    end
  end
end