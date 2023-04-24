require 'rails_helper'

describe "As a user" do
  describe "I can request infromation on salary by city" do
    it "GET /api/v1/salaries?destination=chicago" do
      VCR.use_cassette("chicago_salaries") do
        get '/api/v1/salaries?destination=chicago'
      end

      json = JSON.parse(@response.body, symbolize_names: true)


      expect(response.status).to eq 200
      expect(json[:data][:attributes].keys).to include(:destination, :forecast, :salaries)
      expect(json[:data][:attributes][:destination]).to eq('chicago')
      expect(json[:data][:attributes][:forecast].keys).to include(:summary, :temperature) 
      expect(json[:data][:attributes][:salaries].first.keys).to include(:title, :min, :max)
    end
  end
end