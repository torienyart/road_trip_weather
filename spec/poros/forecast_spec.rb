require 'rails_helper'
require './spec/poros/helper'

describe Forecast do
  it "can create an object w/ correct attributes from incoming JSON" do
    forecast = Forecast.new(forecast_info_hash)
    expect(forecast).to be_instance_of(Forecast)
    expect(forecast.current_weather).to be_a Hash
    expect(forecast.daily_weather).to be_a Array
    expect(forecast.daily_weather.first).to be_a Hash
    expect(forecast.hourly_weather).to be_a Array
    expect(forecast.hourly_weather.first).to be_a Hash

  end
end