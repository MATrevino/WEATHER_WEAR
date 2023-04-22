class WeatherService
  def get_forcast(location)
    get_url("/api/v1/forcast?location=#{location}")
  end
  
  private
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def self.conn 
    Faraday.new(url: "http://api.weatherapi.com/v1") do |faraday|
      faraday.params["api_key"] = ENV["WEATHER_API_KEY"]
    end
  end
end