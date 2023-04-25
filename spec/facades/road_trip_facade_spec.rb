require 'rails_helper'

describe RoadTripFacade do
  describe 'instance methods' do
    it "#trip_info" do
      params = {origin: "Cincinatti,OH", destination: "Chicago,IL", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11", controller: "api/v0/road_trip", action: "create"}

      VCR.use_cassette("chicago_road_trip_info") do
        @facade = RoadTripFacade.new(params).trip_info
      end

      expect(@facade).to be_a RoadTrip                  
    end

    it "#travel_time" do
      params = {origin: "Cincinatti,OH", destination: "Chicago,IL", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11", controller: "api/v0/road_trip", action: "create"}

      VCR.use_cassette("chicago_road_trip") do
        @facade = RoadTripFacade.new(params).travel_time
      end

      expect(@facade).to eq("04:40:45")
    end

    it "#impossible_travel_time" do
      params = {origin: "New York,NY", destination: "London,UK", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11", controller: "api/v0/road_trip", action: "create"}

      VCR.use_cassette("impossible_road_trip") do
        @facade = RoadTripFacade.new(params).travel_time
      end

      expect(@facade).to eq("impossible route")
    end

    it "#travel_time_in_seconds" do
      params = {origin: "Cincinatti,OH", destination: "Chicago,IL", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11", controller: "api/v0/road_trip", action: "create"}

      VCR.use_cassette("chicago_road_trip") do
        @facade = RoadTripFacade.new(params).travel_time_in_seconds
      end

      expect(@facade).to eq(16845)
    end

    it "#eta_weather_info #weather_later_today" do
      params = {origin: "Cincinatti,OH", destination: "Chicago,IL", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11", controller: "api/v0/road_trip", action: "create"}

      VCR.use_cassette("chicago_road_trip_2") do
        @facade = RoadTripFacade.new(params).eta_weather_info
      end
      
      expect(@facade).to be_a Hash
      expect(@facade.keys).to include(:datetime, :temperature, :condition)
      expect(@facade[:datetime]).to include((Date.today.day).to_s)
    end
  end
end