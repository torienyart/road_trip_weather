class WeatherService
  def self.location_weather(coordinates)
    get_url("/v1/forecast.json?key=#{ENV['weather_api_key']}&q=#{coordinates}&days=5&aqi=no&alerts=no")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn 
    Faraday.new(url: "https://api.weatherapi.com")
  end
end