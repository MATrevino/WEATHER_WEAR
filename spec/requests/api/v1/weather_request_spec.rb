require 'rails_helper'

RSpec.describe 'receive forecast for a city' do
  describe 'provides forecast for given location' do
    it 'returns lat and long for a given city' do
      VCR.use_cassette('lat_long_for_denver') do
      # VCR.use_cassette('forecast_for_denver') do
        location = 'denver,co'
        get "/api/v1/forecast?location=#{location}"
        
        info = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(info).to be_a(Hash)
        expect(info[:data]).to be_a(Hash)
        expect(info[:data][:id]).to eq('null')
        expect(info[:data][:type]).to eq('forecast')
        expect(info[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
        expect(info[:data][:attributes][:current_weather].keys).to eq([:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon])
        expect(info[:data][:attributes][:current_weather].keys).to_not eq([:temp_c, :feelslike_c, :vis_km, :wind_kph])
        expect(info[:data][:attributes][:daily_weather].first.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon])
        expect(info[:data][:attributes][:hourly_weather].first.keys).to eq([:time, :temperature, :conditions, :icon])
      end
    end

    it 'returns an error if location is invalid' do
      location = ''
      get "/api/v1/forecast?location=#{location}"

      expect(response).to_not be_successful
    end
  end
end