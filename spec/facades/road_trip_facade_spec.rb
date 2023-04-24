require 'rails_helper'

describe RoadTripFacade do
  describe 'instance methods' do
    it "can create a hash with trip information" do
      params = {origin: "Cincinatti,OH", destination: "Chicago,IL", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11", controller: "api/v0/road_trip", action: "create"}

      VCR.use_cassette("chicago_road_trip") do
        @facade = RoadTripFacade.new(params).trip_info
      end

      expect(@facade).to be_a Hash
      expect(@facade[:data][:attributes]).to include(:start_city, :end_city, :travel_time, :weather_at_eta)    
      expect(@facade[:data][:attributes].keys.count).to eq(4)                   
    end

    it "can calculate travel time" do
      params = {origin: "Cincinatti,OH", destination: "Chicago,IL", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11", controller: "api/v0/road_trip", action: "create"}

      VCR.use_cassette("chicago_road_trip") do
        @facade = RoadTripFacade.new(params).travel_time
      end

      expect(@facade).to eq("04:40:45")
    end

    it "can create a hash with weather at eta information" do
      params = {origin: "Cincinatti,OH", destination: "Chicago,IL", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11", controller: "api/v0/road_trip", action: "create"}

      VCR.use_cassette("chicago_road_trip") do
        @facade = RoadTripFacade.new(params).eta_weather_info
      end

      expect(@facade).to be_a EtaWeatherInfo
      expect(@facade.datetime).to be_a String  
      expect(@facade.temperature).to be_a Float
      expect(@facade.condition).to be_a String
    end
  end
end