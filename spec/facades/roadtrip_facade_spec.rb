require 'rails_helper'

RSpec.describe 'can request a roadtrip' do
  describe 'happy path' do
    it 'can return a roadtrip' do
      VCR.use_cassette('roadtrip') do
        origin = 'denver, co'
        destination = 'pueblo, co'
        response = RoadtripFacade.travel_info(origin, destination)

        expect(response).to be_a(Roadtrip)
        expect(response.start_city).to eq(origin)
        expect(response.end_city).to eq(destination)
        expect(response.travel_time).to be_a(String)
        expect(response.weather_at_eta).to be_a(Hash)
        expect(response.weather_at_eta.keys).to eq([:datatime, :temperatur, :condition])
      end
    end
  end
end