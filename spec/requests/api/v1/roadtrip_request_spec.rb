require 'rails_helper'

RSpec.describe 'can request a roadtrip' do
  describe 'happy path' do
    it 'can return a roadtrip' do
      request = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
      }

      VCR.use_cassette('roadtrip_for_request') do
        post '/api/v1/road_trip', params: request.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        expect(response).to be_successful
        expect(response.status).to eq(201)
        data = JSON.parse(response.body, symbolize_names: true)
      
        expect(data[:data].keys).to eq([:id, :type, :attributes])
        expect(data[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
        expect(data[:data][:attributes][:weather_at_eta].keys).to eq([:datatime, :temperature, :condition])
      end
    end
  end
end