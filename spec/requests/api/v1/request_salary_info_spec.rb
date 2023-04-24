require 'rails_helper'

RSpec.describe 'receive salary info for a city' do
  describe 'provides salary info for given location' do
    it 'returns salary info for a given city' do
      VCR.use_cassette('salary_for_chicago') do
        get '/api/v1/salaries?destination=chicago'

        data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(data).to be_a(Hash)
        expect(data[:data].keys).to eq([:id, :type, :attributes])
        expect(data[:data][:id]).to eq("null")
        expect(data[:data][:type]).to eq("salaries")
        expect(data[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
        expect(data[:data][:attributes][:destination]).to eq("Chicago")
        expect(data[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
        expect(data[:data][:attributes][:salaries].count).to eq(7)
        expect(data[:data][:attributes][:salaries]).to_not include("title" => "Chef")
      end
    end
  end
end