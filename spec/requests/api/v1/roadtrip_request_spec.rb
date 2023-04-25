require 'rails_helper'

RSpec.describe 'can request a roadtrip' do
  describe 'happy path' do
    it 'can return a roadtrip' do
      user_input = {
        email: 'gmail@gmail.com',
        password: 'password',
        password_confirmation: 'password'
        }
  
      post '/api/v1/users', params: user_input.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      info = JSON.parse(response.body, symbolize_names: true)
      api_key = info[:data][:attributes][:api_key]

      request = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": api_key
      }

      VCR.use_cassette('roadtrip_for_request') do
        post '/api/v1/road_trip', params: request.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        expect(response).to be_successful
        expect(response.status).to eq(201)
        data = JSON.parse(response.body, symbolize_names: true)
      
        expect(data[:data].keys).to eq([:id, :type, :attributes])
        expect(data[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
        expect(data[:data][:attributes][:weather_at_eta].keys).to eq([:datetime, :temperature, :condition])
      end
    end

    describe 'can return a roadtrip that is over 24 hours' do
      it 'can return a roadtrip' do
        user_input = {
          email: 'gmail@gmail.com',
          password: 'password',
          password_confirmation: 'password'
          }
    
        post '/api/v1/users', params: user_input.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
        info = JSON.parse(response.body, symbolize_names: true)
        api_key = info[:data][:attributes][:api_key]
        request = {
          "origin": "New York, NY",
          "destination": "Los Angeles, CA",
          "api_key": api_key
        }
        VCR.use_cassette('roadtrip_over_24') do
          post '/api/v1/road_trip', params: request.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

          expect(response).to be_successful
          expect(response.status).to eq(201)
          data = JSON.parse(response.body, symbolize_names: true)
        
          expect(data[:data].keys).to eq([:id, :type, :attributes])
          expect(data[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
          expect(data[:data][:attributes][:weather_at_eta].keys).to eq([:datetime, :temperature, :condition])
        end
      end
    end
  end

  describe 'sad path' do
    it 'cannot return a roadtrip with missing api key' do
      request = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": " "
      }

      VCR.use_cassette('roadtrip_with_bad_api') do
        post '/api/v1/road_trip', params: request.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        data = JSON.parse(response.body, symbolize_names: true)
        
        expect(data[:error]).to eq('API key is invalid')
      end
    end

    describe 'cannot return a roadtrip with missing origin or destination' do
      it 'cannot return a roadtrip with missing origin' do
        user_input = {
          email: 'gmail@gmail.com',
          password: 'password',
          password_confirmation: 'password'
          }
    
        post '/api/v1/users', params: user_input.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
        info = JSON.parse(response.body, symbolize_names: true)
        api_key = info[:data][:attributes][:api_key]  
      
        request = {
          "origin": "",
          "destination": "Chicago,IL",
          "api_key": api_key
        }

        VCR.use_cassette('roadtrip_with_missing_origin') do
          post '/api/v1/road_trip', params: request.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
            
            expect(response).to_not be_successful
            expect(response.status).to eq(400)
  
            data = JSON.parse(response.body, symbolize_names: true)
            
            expect(data[:error]).to eq('Origin and destination are required fields')
        end
      end
    end
    it 'cannot return a roadtrip where origin and destination are the same' do
      user_input = {
        email: 'gmail@gmail.com',
        password: 'password',
        password_confirmation: 'password'
        }
  
      post '/api/v1/users', params: user_input.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      info = JSON.parse(response.body, symbolize_names: true)
      api_key = info[:data][:attributes][:api_key] 

      request = {
        "origin": "Chicago,IL",
        "destination": "Chicago,IL",
        "api_key": api_key
      }
      VCR.use_cassette('roadtrip_with_same_origin_destination') do
        post '/api/v1/road_trip', params: request.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
            
        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:error]).to eq('Origin and destination cannot be the same')
      end
    end
    
    it 'cannot return a roadtrip if destination is impossible' do
      user_input = {
        email: 'gmail@gmail.com',
        password: 'password',
        password_confirmation: 'password'
        }
  
      post '/api/v1/users', params: user_input.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      info = JSON.parse(response.body, symbolize_names: true)
      api_key = info[:data][:attributes][:api_key] 
      
      request = {
        "origin": "Chicago,IL",
        "destination": "London,UK",
        "api_key": api_key
      }
      VCR.use_cassette('roadtrip_with_impossible') do
        post '/api/v1/road_trip', params: request.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        expect(response).to be_successful
       
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:data][:attributes][:start_city]).to eq('Chicago,IL')
        expect(data[:data][:attributes][:travel_time]).to eq('Impossible route')
        expect(data[:data][:attributes][:weather_at_eta]).to eq({})
      end
    end
  end
end