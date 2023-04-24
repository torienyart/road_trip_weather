require 'rails_helper'
require './spec/poros/helper'

describe CurrentWeather do
  it "can create an object w/ correct attributes from incoming JSON" do
    current_weather = CurrentWeather.new(fake_response[:current])
    expect(current_weather).to be_instance_of(CurrentWeather)
    expect(current_weather.condition).to be_a(String)
    expect(current_weather.feels_like).to be_a(Float)
    expect(current_weather.humidity).to be_a(Integer)
    expect(current_weather.icon).to be_a(String)
    expect(current_weather.last_updated).to be_a(String)
    expect(current_weather.temperature).to be_a(Float)
    expect(current_weather.uvi).to be_a(Float)
    expect(current_weather.visibility).to be_a(Float)
  end
end