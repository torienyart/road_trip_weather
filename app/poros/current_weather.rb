class CurrentWeather
  attr_reader :last_updated,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :condition,
              :icon

  def initialize(response_hash)
    @last_updated = response_hash[:last_updated]
    @temperature = response_hash[:temp_f]
    @feels_like = response_hash[:feelslike_f]
    @humidity = response_hash[:humidity]
    @uvi = response_hash[:uv]
    @visibility = response_hash[:vis_miles]
    @condition = response_hash[:condition][:text]
    @icon = response_hash[:condition][:icon]

  end
end