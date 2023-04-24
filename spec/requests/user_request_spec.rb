require 'rails_helper'

describe 'a user can' do
  describe 'POST /api/v0/users' do
    before :each do
      @params = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }

      @params_2 = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "pssword"
      }
    end

    it "can create/register a new user" do
      post '/api/v0/users', params: @params
      json = JSON.parse(@response.body, symbolize_names: true)


      expect(response.status).to eq 201
      expect(json[:data][:id]).to_not eq(nil)
      expect(json[:data][:attributes].keys).to include(:email, :api_key)
      expect(json[:data][:attributes][:email]).to eq("whatever@example.com")
      expect(json[:data][:attributes][:api_key]).to_not be nil
    end

    it "can send an error message if passwords don't match" do
      post '/api/v0/users', params: @params_2
      json = JSON.parse(@response.body, symbolize_names: true)

      expect(response.status).to eq 400
      expect(json[:errors]).to include("Password confirmation doesn't match Password")
    end
  end

end