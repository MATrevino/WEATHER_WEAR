require 'rails_helper'

RSpec.describe 'ForecastFacade' do
  describe 'class methods' do
    it 'returns a forecast object for denver' do
      VCR.use_cassette('lat_long_for_denver') do
        response = ForecastFacade.forecast('denver,co')
        expect(response).to be_a(Forecast)
        expect(response.id).to eq('null')
        expect(response.type).to eq('forecast')
        expect(response.current_weather).to be_a(Array)
        expect(response.current_weather.first.keys).to_not eq([:temp_c, :feelslike_c, :vis_km])
        expect(response.current_weather.first.keys).to eq([:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon])
      end
    end
  end
end