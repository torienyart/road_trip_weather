class ForecastsFacade
  def initialize(params)
    @city = params[:location]
  end

  def city_weather
    
  end

  def latlng_for_city
    response = GeocodingService.latlng_for_city(@city)
    latlng_hash = response[:results][0][:locations][0][:latLng]
    latlng_hash.values.join(", ")
  end
end