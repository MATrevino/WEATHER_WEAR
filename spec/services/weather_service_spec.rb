require 'rails_helper'

RSpec.describe 'WeatherService' do
  describe 'class methods' do
    it 'returns the weather for denver' do
      VCR.use_cassette('weather_get_forcast_for_denver') do
        response = WeatherService.get_forecast(39.74001, -104.99202)

        expect(response).to be_a(Hash)
        expect(response[:forecast][:forecastday].first[:hour]).to be_an(Array)
        expect(response[:forecast][:forecastday].first[:day]).to be_a(Hash)
        # expect(response[:forecast][:forecastday].first[:day].keys).to match([:maxtemp_f, :maxtemp_c, :mintemp_f, :mintemp_c, :avgtemp_f, :avgtemp_c, :maxwind_mph, :maxwind_kph, :totalprecip_in, :totalprecip_mm, :totalsnow_cm, :avgvis_km, :avgvis_miles, :avghumidity, :daily_will_it_rain, :daily_chance_of_rain, :daily_will_it_snow, :daily_chance_of_snow, :condition, :uv])
      end
    end
  end
end