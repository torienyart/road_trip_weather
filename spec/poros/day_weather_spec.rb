require 'rails_helper'
require './spec/poros/helper'

describe DayWeather do
  it "can create an object w/ correct attributes from incoming JSON" do
    day_weather = DayWeather.new(fake_response[:forecast][:forecastday][0])
    expect(day_weather).to be_instance_of(DayWeather)
    expect(day_weather.date).to be_a(String)
    expect(day_weather.sunrise).to be_a(String)
    expect(day_weather.sunset).to be_a(String)
    expect(day_weather.max_temp).to be_a(Float)
    expect(day_weather.min_temp).to be_a(Float)
    expect(day_weather.condition).to be_a(String)
    expect(day_weather.icon).to be_a(String)
  end
end