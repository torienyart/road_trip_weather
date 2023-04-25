require 'rails_helper'

describe RoadTrip do
  before :each do
    @info_hash = {:start_city=>"Cincinatti,OH",
      :end_city=>"Chicago,IL",
      :travel_time=>"04:40:45",
      :weather_at_eta=>
       {:datetime=>"2023-04-25 17:00", :temperature=>42.1, :condition=>"Cloudy"}}
  end

  it "can create an object w/ correct attributes from incoming JSON" do
    road_trip = RoadTrip.new(@info_hash)
    expect(road_trip).to be_instance_of(RoadTrip)
    expect(road_trip.start_city).to eq("Cincinatti,OH")
    expect(road_trip.end_city).to eq("Chicago,IL")
    expect(road_trip.travel_time).to eq("04:40:45")
    expect(road_trip.weather_at_eta).to be_a(Hash)
    expect(road_trip.weather_at_eta).to eq({:datetime=>"2023-04-25 17:00", :temperature=>42.1, :condition=>"Cloudy"})
  end
end