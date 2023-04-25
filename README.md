# README

## Learning Goals

* Expose an API that aggregates data from multiple external APIs
* Expose an API that requires an authentication token
* Expose an API for CRUD functionality
* Determine completion criteria based on the needs of other developers
* Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).


## Getting Started
In order to use this repo on your local machine, use the following steps

1. Fork and clone this repository
2. Run `bundle install`
3. Gather your API Keys from [Mapquest](https://developer.mapquest.com/documentation/) and [WeatherAPI](https://www.weatherapi.com/)
4. Run `bundle exec figaro install` 
5. Put your API keys into the application.yml file like this:
```
mapquest_api_key: your key here
weather_api_key: your key here
```

## Endpoint Usage

### City Forecast - `GET /api/v0/forecast?location=cincinatti,oh`
This endpoint can be used to gather forecast data for a specific city. It does not require a login. The endpoing will expose weather data for a city by current weather, daily weather, and hourly weather for the day the request was made.

### User Registration - `POST /api/v0/users`
This endpoint can be used along with a request body to create a new user. User must have an email, password, and password confirmation. The endpoint will return the user's email as well as their newly created api-key.

Request Example:
```
{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

### User Login - `POST /api/v0/sessions`
This endpoint can be used along with a request body to login an existing user. User's credentials must be correct. The endpoint will return the user's id, email, and their api-key.

Request Example:
```
POST /api/v0/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```

### Road Trip - `POST /api/v0/road_trip`
This endpoint is used to gather information about a requested road trip. When the api_key, origin, and destination are sent in the request body, the endpoint will return a hash of information. This hash will include the travel time, start and end points, and weather at ETA.

Request Example:
```
POST /api/v0/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Cincinatti,OH",
  "destination": "Chicago,IL",
  "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
}
```
