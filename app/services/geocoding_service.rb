class GeocodingService
  def self.latlong(city)
    get_url("/geocoding/v1/address?key=#{ENV['mapquest_api_key']}&location=#{city}")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn 
    Faraday.new(url: "https://www.mapquestapi.com")
  end
end