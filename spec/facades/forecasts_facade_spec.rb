require 'rails_helper'
require './spec/poros/helper'


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


    describe "city_weather_serializer" do
      it "can create a current weather object" do
        VCR.use_cassette("geocoding_denver") do
          @current_weather = ForecastsFacade.new({location: "denver, co"}).current_weather(fake_response)
        end
        expect(@current_weather).to be_a CurrentWeather
      end

      it "can create daily weather objects" do
        VCR.use_cassette("geocoding_denver") do
          @daily_weather = ForecastsFacade.new({location: "denver, co"}).daily_weather(fake_response)
        end
        
        expect(@daily_weather).to be_a Array
        expect(@daily_weather.count).to be 5
        expect(@daily_weather.first).to be_a DayWeather
      end

      it "can create hourly weather objects" do
        VCR.use_cassette("geocoding_denver") do
          @hourly_weather = ForecastsFacade.new({location: "denver, co"}).hourly_weather(fake_response)
        end
        expect(@hourly_weather).to be_a Array
        expect(@hourly_weather.count).to be 24
        expect(@hourly_weather.first).to be_a HourWeather
      end

      it "can create eta hourly weather objects" do
        VCR.use_cassette("geocoding_denver") do
          @hourly_weather = ForecastsFacade.new({location: "denver, co"}).eta_hourly_weather(fake_response, 2)
        end
        expect(@hourly_weather).to be_a Array
        expect(@hourly_weather.count).to be 24
        expect(@hourly_weather.first).to be_a HourWeather
      end

      it "can serialize all the objects together" do
        VCR.use_cassette("geocoding_denver") do
          @forecast = ForecastsFacade.new({location: "denver, co"}).city_weather_serializer(fake_response)
        end

        expect(@forecast).to be_a Hash
        expect(@forecast[:data][:id]).to eq "null"
        expect(@forecast[:data][:type]).to eq("forecast")
        expect(@forecast[:data][:attributes].keys).to include(:current_weather, :daily_weather, :hourly_weather)
      end
    end
  end
end