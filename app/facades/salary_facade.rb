class SalaryFacade

  def self.salary_info(location)
    data_for_ll = MapquestService.get_lat_long(location)
    lat = data_for_ll[:results].first[:locations].first[:latLng][:lat]
    long = data_for_ll[:results].first[:locations].first[:latLng][:lng]
    data = WeatherService.get_forecast(lat, long)
    
    destination = data[:location][:name]
    forecast =
    { 
      summary: data[:current][:condition][:text],
      temperature: "#{data[:current][:temp_f].to_i} F"
    }
      big_info = TeleportService.urban_area_salaries(location)

    wanted_jobs = ["Data Analyst", "Data Scientist", "Mobile Developer", "QA Engineer", "Software Engineer", "Systems Administrator", "Web Developer"]
    
    salary = big_info[:salaries].select do |salary|
      wanted_jobs.include?(salary[:job][:title])
    end.map do |salary|
      {
        title: salary[:job][:title],
        min: sprintf("$%.2f", salary[:salary_percentiles][:percentile_25]),
        max: sprintf("$%.2f", salary[:salary_percentiles][:percentile_75])
        }
    end

    salary_info = Salary.new(destination, forecast, salary)
  end
end