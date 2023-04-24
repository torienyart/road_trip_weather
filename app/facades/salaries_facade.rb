class SalariesFacade
  attr_reader :destination

  def initialize(params)
    @destination = params[:destination]
  end

  def destination_salaries
    response = TeleportService.destination_salaries(@destination)
    poros = response[:salaries].each do |salary_info|
      Salary.new(salary_info)
    end
  end
end