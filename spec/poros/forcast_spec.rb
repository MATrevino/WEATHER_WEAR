require 'rails_helper'

RSpec.describe 'Forecast poro' do
  describe 'class methods' do
    it 'returns a forecast object' do
      VCR.use_cassette('forecast_for_denver') do
        response = ForecastFacade.forecast('denver,co')
        expect(response).to be_a(Forecast)
      end
    end
  end
end