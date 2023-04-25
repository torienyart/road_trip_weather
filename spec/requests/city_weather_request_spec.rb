require 'rails_helper'

describe 'Retrieve Weather for a city' do
  describe "GET /api/v0/?location=cincinatti,oh" do

    before :each do
      VCR.use_cassette("cincinatti_weather_forecast") do
        get '/api/v0/forecast?location=cincinatti,oh'
      end

      @response = response

      @json = JSON.parse(@response.body, symbolize_names: true)
    end

    it "returns a nested hash" do
      expect(response.status).to eq(200)
      expect(@json[:data][:id]).to eq(nil)
      expect(@json[:data][:type]).to eq("forecast")
      expect(@json[:data][:attributes]).to include(:current_weather, :daily_weather, :hourly_weather)    
      expect(@json[:data][:attributes].keys.count).to eq(3)                                                  

    end

    it "returns the current weather attributes" do
      expect(@json[:data][:attributes][:current_weather].keys.count).to eq(8)
      expect(@json[:data][:attributes][:current_weather][:last_updated]).to be_a(String)
      expect(@json[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(@json[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
      expect(@json[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)
      expect(@json[:data][:attributes][:current_weather][:uvi]).to be_a(Float)
      expect(@json[:data][:attributes][:current_weather][:visibility]).to be_a(Float)
      expect(@json[:data][:attributes][:current_weather][:condition]).to be_a(String)
      expect(@json[:data][:attributes][:current_weather][:icon]).to be_a(String)
    end

    it "returns the daily weather attributes" do
      day_weather = @json[:data][:attributes][:daily_weather].first
      expect(@json[:data][:attributes][:daily_weather].count).to eq(5)
      expect(day_weather.keys.count).to eq(7)
      expect(day_weather[:date]).to eq(Date.today.strftime("%Y-%m-%d"))
      expect(day_weather[:sunrise]).to be_a(String)
      expect(day_weather[:sunset]).to be_a(String)      
      expect(day_weather[:max_temp]).to be_a(Float)
      expect(day_weather[:min_temp]).to be_a(Float)
      expect(day_weather[:condition]).to be_a(String)
      expect(day_weather[:icon]).to be_a(String)
    end

    it "returns the hourly weather attributes" do
      expect(@json[:data][:attributes][:hourly_weather]).to be_a(Array)
      expect(@json[:data][:attributes][:hourly_weather].count).to eq(24)


      hour_1 = @json[:data][:attributes][:hourly_weather].first 

      expect(hour_1.keys.count).to eq(4)
      expect(hour_1[:time]).to be_a(String)
      expect(hour_1[:temperature]).to be_a(Float)
      expect(hour_1[:condition]).to be_a(String)
      expect(hour_1[:icon]).to be_a(String)
    end
  end

  describe "sad_path" do
    before :each do
      VCR.use_cassette("bad_request") do
        get '/api/v0/forecast'
      end

      @response = response
      @json = JSON.parse(@response.body, symbolize_names: true)
    end

    it "returns an error message for a bad response" do
      expect(@response.status).to be 400
      expect(@json[:errors]).to eq("Bad request, please check your location information and try again")
    end
  end
end