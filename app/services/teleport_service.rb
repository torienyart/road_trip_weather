class TeleportService
  def self.destination_salaries(destination)
    get_url("/api/urban_areas/slug:#{destination}/salaries")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn 
    Faraday.new(url: "https://api.teleport.org")
  end
end