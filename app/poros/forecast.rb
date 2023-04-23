class Forecast
  attr_reader :id, :type, :attributes

  def initialize(data)
    @id = nil
    @type = 'forecast'
    @attributes = {
      current_weather: current_weather(data[:current]),
      daily_weather: daily_weather(data),
      hourly_weather: hourly_weather(data) 
    }
  end

  def current_weather(data)
    current_weather =
    {
      last_updated: data[:last_updated],
      temperature: data[:temp_f],
      feels_like: data[:feelslike_f],
      humidity: data[:humidity],
      uvi: data[:uv],
      visibility: data[:vis_miles],
      condition: data[:condition][:text],
      icon: data[:condition][:icon]
    }
  end

  def daily_weather(data)
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
    daily_weather
  end

  def hourly_weather(data)
    hourly_weather = data[:forecast][:forecastday].first[:hour].map do |hour|
      {
        time: hour[:time],
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
    hourly_weather
  end
end