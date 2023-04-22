require 'rails_helper'

describe ForecastsFacade do
  describe "class methods" do
    it "can create a hash of city weather" do
      VCR.use_cassette("forcast_for_denver") do
        @forecasts_facade = ForecastsFacade.new({location: "denver, co"}).city_weather
      end

      expect(@forecasts_facade).to be_a Hash
      expect(@forecasts_facade[:data][:attributes]).to include(:current_weather, :daily_weather, :hourly_weather)    
      expect(@forecasts_facade[:data][:attributes].keys.count).to eq(3)                                                  
    end
  end

  describe "helper methods" do
    it "can get the string of lattitude and longitude from geocoding service" do
      VCR.use_cassette("geocoding_denver") do
        @latlng_facade = ForecastsFacade.new({location: "denver, co"}).latlng_for_city
      end

      expect(@latlng_facade).to be_a String
      expect(@latlng_facade).to eq("39.74001, -104.99202")
    end
  end
end