require 'rails_helper'

describe GeocodingService do
  it "returns a lattitude and longitude based on city and state" do
    VCR.use_cassette("geocoding_denver") do
      @latlong = GeocodingService.latlng_for_city("denver,co")
    end

    expect(@latlong).to be_a(Hash)
    expect(@latlong[:results][0][:locations][0][:latLng]).to be_a(Hash)
    expect(@latlong[:results][0][:locations][0][:latLng].keys).to include(:lat, :lng)
  end
end