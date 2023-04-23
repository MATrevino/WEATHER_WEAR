require 'rails_helper'

RSpec.describe 'Forecast poro' do
  describe 'class methods' do
    it 'returns a forecast object' do
      VCR.use_cassette('forecast_for_denver') do
        response = ForecastFacade.forecast('denver,co')

        expect(response).to be_a(Forecast)
        expect(response.id).to eq('null')
        expect(response.type).to eq('forecast')
        expect(response.attributes).to be_a(Hash)
        expect(response.attributes.keys).to eq([:current_weather, :daily_weather, :hourly_weather])
        expect(response.attributes[:current_weather]).to be_a(Hash)
      end
    end
  end
end