class SalariesSerializer
  def self.serialized_destination_info(destination, salaries, forecast)
    {
      data: {
        id: "null",
        type: "salaries",
        attributes: {
          destination: destination,
          forecast: forecast_hash(forecast),
          salaries: salaries_array(salaries)
        }
      }
    }
  end

  def self.salaries_array(salaries)
    salaries.map do |salary|
      h = {}
      h[:title] = salary.title
      h[:min] = salary.min
      h[:max] = salary.max
      h
    end
  end

  def self.forecast_hash(forecast)
    {
      summary: forecast.condition,
      temperature: "#{forecast.temperature.to_i} F"
    }
  end
end