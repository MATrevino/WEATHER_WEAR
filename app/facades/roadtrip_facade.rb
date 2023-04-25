class RoadtripFacade
  def self.travel_info(origin, destination)
    data = MapquestService.get_lat_long(destination)
    lat = data[:results].first[:locations].first[:latLng][:lat]
    long = data[:results].first[:locations].first[:latLng][:lng]
    data = WeatherService.get_forecast(lat, long)
    
    trip_info = MapquestService.get_directions(origin, destination)
   
    travel_time = trip_info[:route][:formattedTime]
    hours = travel_time[0..1].to_i
    minutes = travel_time[3..4].to_i
    rounded_time = (minutes >= 30 ? hours + 1 : hours)

    time_of_arrival = Time.now + (rounded_time * 60 * 60)
    rounded_hours = (time_of_arrival.min < 30) ? time_of_arrival.hour : time_of_arrival.hour + 1
    formatted_time = time_of_arrival.strftime("%Y-%m-%d #{rounded_hours}:00")
    
    hourly_weather = data[:forecast][:forecastday].first[:hour].select do |hour|
      hour[:time] == formatted_time
    end
  

    weather_at_eta = {
      datatime: hourly_weather.first[:time],

      temperatur: hourly_weather.first[:temp_f],
      condition: hourly_weather.first[:condition][:text]
      }


    Roadtrip.new(origin, destination, travel_time, weather_at_eta)
  end
end