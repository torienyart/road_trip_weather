class TripInfoSerializer
  def self.trip_info_hash(start, stop, travel_time, weather_info)
    { data: {
      id: "null",
      type: "road_trip",
      attributes: {
        start_city: start,
        end_city: stop,
        travel_time: travel_time,
        weather_at_eta: weather_info_hash(weather_info)
      }
    }

    }
  end

  def self.weather_info_hash(weather_info)
    if weather_info != {}
      {
        datetime: weather_info.time,
        temperature: weather_info.temperature,
        condition: weather_info.condition
      }
    else
      weather_info
    end
  end
end