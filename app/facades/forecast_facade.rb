class ForecastFacade
  
  def self.forecast(location)
    data = MapquestService.get_lat_long(location)
    lat = data[:results].first[:locations].first[:latLng][:lat]
    long = data[:results].first[:locations].first[:latLng][:lng]
    response = WeatherService.get_forecast(lat, long)
    Forecast.new(response)
  end
end