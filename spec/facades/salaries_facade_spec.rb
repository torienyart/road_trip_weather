require 'rails_helper'

describe SalariesFacade do
  before :each do
    params = {destination: "chicago", controller: "api/v1/salaries", action: "city_salaries"}
    @facade = SalariesFacade.new(params)
  end

  it "can exist" do
    expect(@facade.destination).to eq("chicago")
  end

  it "can pull salary information by destination city" do
    VCR.use_cassette("salaries_chicago") do
      @salaries = @facade.destination_salaries
    end

    expect(@salaries).to be_a(Array)
    expect(@salaries.first).to be_a(Salary)
    expect(@salaries.count).to be <= 7
  end

  it "can pull the forecast information for the same destination" do
    VCR.use_cassette("forecast_chicago") do
      @forecast = @facade.destination_forecast
    end

    expect(@forecast).to be_a(CurrentWeather)
  end

  it "can serialize the forecast and salary information together" do
    VCR.use_cassette("salary_forecast_chicago") do
      @forecast = @facade.serialized_destination_salaries
    end
    
    expect(@forecast).to be_a Hash
    expect(@forecast[:data].keys).to include(:id, :type, :attributes)
    expect(@forecast[:data][:attributes]).to include(:destination, :forecast, :salaries)
  end
end