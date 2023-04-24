class SalaryFacade

  def self.salary_info(location)
    data = MapquestService.get_lat_long(location)
    lat = data[:results].first[:locations].first[:latLng][:lat]
    long = data[:results].first[:locations].first[:latLng][:lng]
    data = WeatherService.get_forecast(lat, long)
    
    destination = data[:location][:name]
    forecast =
    { 
      condition: data[:current][:condition][:text],
      temperature: data[:current][:temp_f],
    }
    urban_area = TeleportService.get_ua_id(location)
  
  
    if locaton == 'chicago'
      urban_area_id = 'dp3wn'
      salary = TeleportService.urban_area_salaries(urban_area_id)
      binding.pry
    end


    salary_info = Salary.new(destination, forecast, salary)
  end

end