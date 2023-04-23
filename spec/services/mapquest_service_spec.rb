require 'rails_helper'

RSpec.describe 'MapquestService' do
  describe 'class methods' do
    it 'returns the lat and long for denver' do
      VCR.use_cassette('mapquest_get_lat_long_for_denver') do
        response = MapquestService.get_lat_long('denver,co')

        expect(response).to be_a(Hash)
        expect(response[:results].first[:locations].first[:latLng].keys).to eq([:lat, :lng])
        expect(response[:results].first[:locations].first[:latLng][:lat]).to eq(39.74001)
        expect(response[:results].first[:locations].first[:latLng][:lng]).to eq(-104.99202)
      end
    end
  end
end