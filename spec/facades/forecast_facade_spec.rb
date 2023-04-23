require 'rails_helper'

RSpec.describe 'ForecastFacade' do
  describe 'class methods' do
    it 'returns a forecast object for denver' do
      VCR.use_cassette('lat_long_for_denver') do

        response = ForecastFacade.forecast('denver,co')
        expect(response).to be_a(Forecast)
        expect(response.attributes.keys).to eq([:current_weather, :daily_weather, :hourly_weather])
      end
    end
  end
end