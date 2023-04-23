class ForecastFacade
  
  def self.forecast(location)
    data = MapquestService.get_lat_long(location)
    lat = data[:results].first[:locations].first[:latLng][:lat]
    long = data[:results].first[:locations].first[:latLng][:lng]
    data = WeatherService.get_forecast(lat, long)
    
    current_weather =
    {
      last_updated: data[:current][:last_updated],
      temperature: data[:current][:temp_f],
      feels_like: data[:current][:feelslike_f],
      humidity: data[:current][:humidity],
      uvi: data[:current][:uv],
      visibility: data[:current][:vis_miles],
      condition: data[:current][:condition][:text],
      icon: data[:current][:condition][:icon]
    }
    
    daily_weather = data[:forecast][:forecastday].map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end

      hourly_weather = data[:forecast][:forecastday].first[:hour].map do |hour|
        {
          time: hour[:time],
          temperature: hour[:temp_f],
          conditions: hour[:condition][:text],
          icon: hour[:condition][:icon]
        }
      end
    x =Forecast.new(current_weather, daily_weather, hourly_weather)
  end
end