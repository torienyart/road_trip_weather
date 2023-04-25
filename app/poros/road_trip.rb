class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta, :id
  
  def initialize(info_hash)
    @id = nil
    @start_city = info_hash[:start_city]
    @end_city = info_hash[:end_city]
    @travel_time = info_hash[:travel_time]
    @weather_at_eta = info_hash[:weather_at_eta]
  end
end