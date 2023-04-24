class SalariesFacade
  attr_reader :destination

  def initialize(params)
    @destination = params[:destination]
  end

  def serialized_destination_salaries
    SalariesSerializer.serialized_destination_info(@destination, destination_salaries, destination_forecast)
  end

  def destination_salaries
    response = TeleportService.destination_salaries(@destination)
    poros = response[:salaries].map do |salary_info|
      Salary.new(salary_info)
    end
    desired_salaries(poros)
  end

  def desired_salaries(salary_objects)
    salary_objects.find_all do |object|
      ["Data Analyst", "Data Scientist", "Mobile Developer", "QA Engineer", "Software Engineer", "Systems Administrator", "Web Developer"].include?(object.title)
    end
  end

  def destination_forecast
    params = {}
    params[:location] = @destination
    facade = ForecastsFacade.new(params)
    facade.current_weather(facade.city_weather_response[:current])
  end
end