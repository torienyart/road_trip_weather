require 'rails_helper'
require './spec/poros/helper'

describe HourWeather do
  it "can create an object w/ correct attributes from incoming JSON" do
    hour_weather = HourWeather.new(response[:forecast][:forecastday][0][:hour][0])
    expect(hour_weather).to be_instance_of(HourWeather)
    expect(hour_weather.time).to be_a(String)
    expect(hour_weather.temperature).to be_a(Float)
    expect(hour_weather.condition).to be_a(String)
    expect(hour_weather.icon).to be_a(String)
  end
end