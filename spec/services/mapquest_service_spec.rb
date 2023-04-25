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

    it 'returns directions from origin to destination' do
      VCR.use_cassette('mapquest_get_directions_from_origin_to_destination') do
        origin = 'denver, co'
        destination = 'chicago, il'

        response = MapquestService.get_directions(origin, destination)

        expect(response).to be_a(Hash)
        expect(response[:route][:formattedTime]).to be_a(String)
        expect(response[:route][:formattedTime]).to eq('14:15:52')
        expect(response[:route][:locations].first[:adminArea5]).to eq('Denver')
        expect(response[:route][:locations].first[:adminArea3]).to eq('CO')
        expect(response[:route][:locations][1][:adminArea5]).to eq('Chicago')
        expect(response[:route][:locations][1][:adminArea3]).to eq('IL')
      end
    end
  end
end