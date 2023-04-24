require 'rails_helper'

describe MapService do
  it "returns a hash of times for travel between two cities" do
    VCR.use_cassette("chicago_road_trip") do
      @times = MapService.travel_time("Cincinatti, OH", "Chicaco, IL")
    end

    expect(@times).to be_a Hash
    expect(@times[:time][1]).to be 16892
  end
end