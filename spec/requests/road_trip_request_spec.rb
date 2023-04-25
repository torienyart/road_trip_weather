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

      @params_3 = {
        "origin": "New York,NY",
        "destination": "Los Angeles,CA",
        "api_key": @user.api_key
      }

      @params_4 = {
        "origin": "New York,NY",
        "destination": "London,UK",
        "api_key": @user.api_key
      }

      @params_5 = {
        "origin": "New York,NY",
        "destination": "London,UK",
        "api_key": 'beepboopbop'
      }
    end

    it "can return the correct road trip information for a valid trip" do
      VCR.use_cassette('chicago_road_trip_info') do
        post '/api/v0/road_trip', params: @params_2
      end
      json = JSON.parse(response.body, symbolize_names: true)

      expect(@response.status).to eq 200
      expect(json[:data][:id]).to eq(nil)
      expect(json[:data][:type]).to eq("road_trip")
      expect(json[:data][:attributes]).to include(:start_city, :end_city, :travel_time, :weather_at_eta)  
      expect(json[:data][:attributes].keys.count).to eq(4)         
      expect(json[:data][:attributes][:weather_at_eta].keys).to include(:datetime, :temperature, :condition)
      expect(json[:data][:attributes][:start_city]).to eq("Cincinatti,OH")
      expect(json[:data][:attributes][:end_city]).to eq("Chicago,IL")
      expect(json[:data][:attributes][:travel_time]).to eq("04:40:45")      
    end

    it "can return the correct road trip information for a valid trip that is longer than a day" do
      VCR.use_cassette('la_road_trip_info') do
        post '/api/v0/road_trip', params: @params_3
      end
      json = JSON.parse(response.body, symbolize_names: true)

      expect(@response.status).to eq 200
      expect(json[:data][:id]).to eq(nil)
      expect(json[:data][:type]).to eq("road_trip")
      expect(json[:data][:attributes]).to include(:start_city, :end_city, :travel_time, :weather_at_eta)  
      expect(json[:data][:attributes].keys.count).to eq(4)         
      expect(json[:data][:attributes][:weather_at_eta].keys).to include(:datetime, :temperature, :condition)
      expect(json[:data][:attributes][:start_city]).to eq("New York,NY")
      expect(json[:data][:attributes][:end_city]).to eq("Los Angeles,CA")
      expect(json[:data][:attributes][:travel_time]).to eq("40:10:42")      
    end

    it "can return a hash with errors if the trip is not possible" do
      VCR.use_cassette('impossible_road_trip_info') do
        post '/api/v0/road_trip', params: @params_4
      end
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(@response.status).to eq 200
      expect(json[:data][:id]).to eq(nil)
      expect(json[:data][:type]).to eq("road_trip")
      expect(json[:data][:attributes]).to include(:start_city, :end_city, :travel_time, :weather_at_eta)  
      expect(json[:data][:attributes].keys.count).to eq(4)         
      expect(json[:data][:attributes][:weather_at_eta]).to eq({})
      expect(json[:data][:attributes][:start_city]).to eq("New York,NY")
      expect(json[:data][:attributes][:end_city]).to eq("London,UK")
      expect(json[:data][:attributes][:travel_time]).to eq("impossible route")      
    end

    it "can return an error message if the api key is invalid" do
      VCR.use_cassette('invalid_key') do
        post '/api/v0/road_trip', params: @params_5
      end

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 401
      expect(json[:errors]).to eq("Invalid API Key")
    end
  end

end