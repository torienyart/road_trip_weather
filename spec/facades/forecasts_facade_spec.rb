require 'rails_helper'
require './spec/facades/helper'


describe ForecastsFacade do
  describe "class methods" do
    it "can create an object of city weather" do
      VCR.use_cassette("forcast_for_denver") do
        @forecasts_facade = ForecastsFacade.new({location: "denver, co"}).city_weather
      end

      expect(@forecasts_facade).to be_a Forecast
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


    describe "city_weather_serializer" do
      it "can create a current weather hash" do
        VCR.use_cassette("geocoding_denver") do
          @current_weather = ForecastsFacade.new({location: "denver, co"}).current_weather(fake_response[:current])
        end
        expect(@current_weather).to be_a Hash
        expect(@current_weather.keys).to include(:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon)
      end

      it "can create daily weather objects" do
        VCR.use_cassette("geocoding_denver") do
          @daily_weather = ForecastsFacade.new({location: "denver, co"}).daily_weather(fake_response)
        end
        
        expect(@daily_weather).to be_a Array
        expect(@daily_weather.count).to be 5
        expect(@daily_weather.first).to be_a Hash
        expect(@daily_weather.first.keys).to include(:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon)
      end

      it "can create hourly weather objects" do
        VCR.use_cassette("geocoding_denver") do
          @hourly_weather = ForecastsFacade.new({location: "denver, co"}).hourly_weather(fake_response)
        end
        expect(@hourly_weather).to be_a Array
        expect(@hourly_weather.count).to be 24
        expect(@hourly_weather.first).to be_a Hash
        expect(@hourly_weather.first.keys).to include(:time, :temperature, :condition, :icon)
      end

      it "can create eta hourly weather objects" do
        VCR.use_cassette("geocoding_denver") do
          @hourly_weather = ForecastsFacade.new({location: "denver, co"}).eta_hourly_weather(fake_response, 2)
        end
        expect(@hourly_weather).to be_a Array
        expect(@hourly_weather.count).to be 24
        expect(@hourly_weather.first).to be_a Hash
        expect(@hourly_weather.first.keys).to include(:datetime, :temperature, :condition)
      end
    end
  end
end