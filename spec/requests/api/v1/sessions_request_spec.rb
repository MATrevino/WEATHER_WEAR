require 'rails_helper'

RSpec.describe 'login a user' do
  before do
    user_input = {
      email: 'gmail@gmail.com',
      password: 'password',
      password_confirmation: 'password'
    }
    post '/api/v1/users', params: user_input.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
  end

  describe 'happy path' do
    it 'can login user' do
      request = {
        email: 'gmail@gmail.com',
        password: 'password'
      }

      post '/api/v1/sessions', params: request.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to have_key(:data)
      expect(data[:data]).to have_key(:id)
      expect(data[:data][:type]).to eq('users')
      expect(data[:data][:attributes].keys).to eq([:email, :api_key])
    end
  end

  describe 'sad path' do
    it 'cannot login user with bad email' do
      request = {
        email: 'badbadbademail@gmail.com',
        password: 'password'
      }

      post '/api/v1/sessions', params: request.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response.status).to eq(400)
      expect(response.body).to eq('{"error":"Invalid credentials"}')
    end

    it 'cannot login user with bad password' do
      request = {
        email: 'gmail@gmail.com',
        password: 'badpassword'
      }

      post '/api/v1/sessions', params: request.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      expect(response.status).to eq(400)
      expect(response.body).to eq('{"error":"Invalid credentials"}')
    end
  end
end