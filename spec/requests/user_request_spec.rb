require 'rails_helper'

describe 'a user can' do
  describe 'POST /api/v0/users' do
    before :each do
      @params = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
    end

    it "can create/register a new user" do
      post '/api/v0/users', params: @params

      expect(response.status).to eq 201
      expect(response.body[:data][:id]).to_not eq(nil)
      expect(response.body[:data][:attributes].keys).to include(:email, :api_key)
      expect(response.body[:data][:attributes][:email]).to eq("whatever@example.com")
    end
  end

end