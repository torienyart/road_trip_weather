require 'rails_helper'

describe 'a user can' do
  describe "POST /api/v0/road_trip" do
    before :each do
      @params = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      
      @user = User.create!(@params)
      
      @params_2 = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": @user.api_key
      }
      
      VCR.use_cassette('chicago_road_trip') do
        post '/api/v0/road_trip', params: @params_2
      end

      @response = response
    end

    it "can return the correct road trip information" do
      json = JSON.parse(@response.body, symbolize_names: true)

      expect(@response.status).to eq 200
      expect(json[:data][:id]).to eq("null")
      expect(@json[:data][:type]).to eq("road_trip")
      expect(@json[:data][:attributes]).to include(:start_city, :end_city, :travel_time, :weather_at_eta)  
      expect(@json[:data][:attributes].keys.count).to eq(4)         
      expect(@json[:data][:attributes][:weather_at_eta].keys).to include(:datetime, :temperature, :condition)
    end
  end
end