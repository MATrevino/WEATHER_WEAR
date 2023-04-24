require 'rails_helper'

RSpec.describe 'ForecastFacade' do
  describe 'class methods' do
    it 'returns a forecast object for denver' do
      VCR.use_cassette('lat_long_for_denver') do
        response = ForecastFacade.forecast('denver,co')
        expect(response).to be_a(Forecast)
        expect(response.id).to eq('null')
        expect(response.type).to eq('forecast')
        expect(response.current_weather).to be_a(Hash)
        expect(response.current_weather.keys).to_not eq([:temp_c, :feelslike_c, :vis_km])
        expect(response.current_weather.keys).to eq([:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon])
        expect(response.daily_weather.first.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon])
        expect(response.hourly_weather.first.keys).to eq([:time, :temperature, :conditions, :icon])
      end
    end
  end
end