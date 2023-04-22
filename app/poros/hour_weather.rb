class HourWeather
  attr_reader :time,
              :temperature,
              :condition,
              :icon

  def initialize(hour_data)
    @time = hour_data[:time]
    @temperature = hour_data[:temp_f]
    @condition = hour_data[:condition][:text]
    @icon = hour_data[:condition][:icon]
  end
end