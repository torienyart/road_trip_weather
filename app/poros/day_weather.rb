class DayWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :condition,
              :icon

  def initialize(day_data)
    @date = day_data[:date]
    @sunrise = day_data[:astro][:sunrise]
    @sunset = day_data[:astro][:sunset]
    @max_temp = day_data[:day][:maxtemp_f]
    @min_temp = day_data[:day][:mintemp_f]
    @condition = day_data[:day][:condition][:text]
    @icon = day_data[:day][:condition][:icon]
  end
end