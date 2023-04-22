require 'rails_helper'

describe 'Retrieve Weather for a city' do
  describe "GET /api/v0/forecast?location=cincinatti,oh" do

    before :each do
      VCR.use_cassette("cincinatti_weather_forecast") do
        get '/api/v0/forecast?location=cincinatti,oh'
      end

      @response = response

      @json = JSON.parse(@response.body, symbolize_names: true)
    end

    it "returns a nested hash" do
      expect(response.status).to eq(200)
      expect(json[:data][:id]).to eq(null)
      expect(json[:data][:type]).to eq("forecast")
      expect(json[:data][:attributes]).to include(:current_weather, :daily_weather, :hourly_weather)
      
      expect(json[:data][:attributes][:current_weather]).to include(:last_updated, 
                                                                    :temperature, 
                                                                    :feels_like, 
                                                                    :humidity, 
                                                                    :uvi, 
                                                                    :visibilty, 
                                                                    :condition, 
                                                                    :icon)
    end

    it "returns the current weather attributes" do
      expect(json[:data][:attributes][:current_weather][:last_updated]).to eq(Time.now.strftime("%Y-%m-%d %H:%M"))
      expect(json[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(json[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
      expect(json[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)
      expect(json[:data][:attributes][:current_weather][:uvi]).to be_a(Integer)
      expect(json[:data][:attributes][:current_weather][:visibility]).to be_a(Integer)
      expect(json[:data][:attributes][:current_weather][:condition]).to be_a(String)
      expect(json[:data][:attributes][:current_weather][:icon]).to be_a(String)
    end

    it "returns the daily weather attributes" do
      expect(json[:data][:attributes][:daily_weather][:date]).to eq(Date.today.strftime("%Y-%m-%d"))
      expect(json[:data][:attributes][:daily_weather][:sunrise].strftime("%I:%M %p")).to eq(json[:data][:attributes][:daily_weather][:sunrise])
      expect(json[:data][:attributes][:daily_weather][:sunset].strftime("%I:%M %p")).to eq(json[:data][:attributes][:daily_weather][:sunset])
      expect(json[:data][:attributes][:daily_weather][:max_temp]).to be_a(Float)
      expect(json[:data][:attributes][:daily_weather][:min_temp]).to be_a(Float)
      expect(json[:data][:attributes][:daily_weather][:condition]).to be_a(String)
      expect(json[:data][:attributes][:daily_weather][:icon]).to be_a(String)
    end

    it "returns the daily weather attributes" do
      expect(json[:data][:attributes][:hourly_weather]).to be_a(Array)

      hour_1 = json[:data][:attributes][:hourly_weather].first 

      expect(hour_1[:time]..strftime("%H:%M")).to eq(hour_1[:time])
      expect(hour_1[:temperature]).to be_a(Float)
      expect(hour_1[:condition]).to be_a(String)
      expect(hour_1[:icon]).to be_a(String)
    end
  end
end