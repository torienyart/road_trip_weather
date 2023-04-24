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
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 201
      expect(json[:data][:id]).to_not eq(nil)
      expect(json[:data][:attributes].keys).to include(:email, :api_key)
      expect(json[:data][:attributes][:email]).to eq("whatever@example.com")
      expect(json[:data][:attributes][:api_key]).to_not be nil
    end

    it "can send an error message if passwords don't match" do
      post '/api/v0/users', params: @params_2
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 400
      expect(json[:errors]).to include("Password confirmation doesn't match Password")
    end
  end

  describe "post api/v0/sessions" do
    before :each do
      @params = {
        "email": "whatever@example.com",
        "password": "password"
      }
      @params_2 = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      @params_3 = {
        "email": "whatever@example.com",
        "password": "badword"
      }
      @params_4 = {
        "email": "inexistent@example.com",
        "password": "badword"
      }
      @user = User.create!(@params_2)
    end

    it "can login a user w/ the correct credentials" do
      post '/api/v0/sessions', params: @params
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to be 200
      expect(json[:data][:id]).to eq(@user.id.to_s)
      expect(json[:data][:attributes].keys).to include(:email, :api_key)
      expect(json[:data][:attributes][:email]).to eq(@user.email)
      expect(json[:data][:attributes][:api_key]).to eq(@user.api_key)
    end

    it "can return an error message if the username and password are incorrect" do
      post '/api/v0/sessions', params: @params_3
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 400
      expect(json[:errors]).to include("Username and password are incorrect")
    end

    it "can return an error message if the user does not exist" do
      post '/api/v0/sessions', params: @params_4
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 400
      expect(json[:errors]).to include("User does not exist, please register")
    end
  end

end