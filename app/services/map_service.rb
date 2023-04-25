class MapService
  def self.travel_time(start, stop)
    url = "/directions/v2/routeMatrix?key=#{ENV['mapquest_api_key']}"
    body = {
      locations: [
        start,
        stop
      ]
    }.to_json

    response = conn.post do |req|
      req.url url
      req.headers['Content-Type'] = 'application/json'
      req.body = body
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn 
    Faraday.new(url: "https://www.mapquestapi.com")
  end
end