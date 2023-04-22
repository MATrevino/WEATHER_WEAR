require 'rails_helper'

RSpec.describe 'Weather API', type: :request do
  describe 'GET /api/v1/forcast?location=denver,co' do
    it 'returns the weather for denver' do
      get '/api/v1/forcast?location=denver,co'
      expect(response).to have_http_status(200)
      
      weather = JSON.parse(response.body, symbolize_names: true)
   
      expect(weather.keys).to eq([:data])
      expect(weather[:data].keys).to eq([:id, :type, :attributes])
      expect(weather[:data][:id]).to eq(nil)
      expect(weather[:data][:type]).to eq('forecast')
      expect(weather[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
      expect(weahter[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(weather[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(weather[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(weather[:data][:attributes][:current_weather].keys).to eq([:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon])


    end
  end
end