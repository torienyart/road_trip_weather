class Forecast
  attr_reader :current_weather, :daily_weather, :hourly_weather, :id

  def initialize(info_hash)
    @id = nil
    @current_weather = info_hash[:current_weather]
    @daily_weather = info_hash[:daily_weather]
    @hourly_weather = info_hash[:hourly_weather]
  end
end