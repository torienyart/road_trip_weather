require 'rails_helper'

describe ForecastsFacade do
  describe "class methods" do
    xit "can create a hash of city weather" do
      VCR.use_cassette("forcast_for_denver")
        @forecast_facade = ForecastFacade.new({location: "denver, co"}).city_weather
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