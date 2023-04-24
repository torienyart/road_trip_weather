require 'rails_helper'

describe WeatherService do
  it "returns a large nested hash" do
    VCR.use_cassette("forecast_denver_2") do
      @forecast = WeatherService.location_weather("39.74001, -104.99202")
    end

    expect(@forecast).to be_a(Hash)
    expect(@forecast[:location][:name]).to eq("Denver")
    expect(@forecast[:location][:region]).to eq("Colorado")
    expect(@forecast[:forecast][:forecastday].count).to eq(5)
    expect(@forecast.keys).to include(:current, :forecast)
  end
end