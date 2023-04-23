require 'rails_helper'

RSpec.describe 'create a user' do
  it 'can create a user' do

    user_input = {
      email: 'gmail@gmail.com',
      password: 'password',
      password_confirmation: 'password'
      }

    post '/api/v1/users', params: user_input.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    expect(response).to be_successful

    info = JSON.parse(response.body, symbolize_names: true)
    expect(info).to have_key(:data)
    expect(info[:data]).to have_key(:id)
    expect(info[:data][:attributes][:email]).to eq(user_input[:email])
    expect(info[:data][:attributes]).to have_key(:api_key)
    expect(info[:data][:attributes]).to have_key(:email) 
    expect(info[:data][:attributes][:api_key]).to be_a(String)
    expect(info[:data][:attributes]).to_not have_key(:password)
    expect(info[:data][:attributes]).to_not have_key(:password_confirmation)
  end

  it 'cannot create a user with passwords not matching' do

    user_input = {
      email: 'hotmail@gmail.com',
      password: 'password123',
      password_confirmation: 'password'
      }

    post '/api/v1/users', params: user_input.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    info = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(response.body).to eq("{\"error\":[\"Password confirmation doesn't match Password\"]}")
  end

  it 'cannot create a user with missing email' do

    user_input = {
      email: '',
      password: 'password',
      password_confirmation: 'password'
      }

    post '/api/v1/users', params: user_input.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(response.body).to eq("{\"error\":[\"Email can't be blank\"]}")
  end

  it 'cannot create a user with password is missing' do

    user_input = {
      email: 'hotmail@yahoo.com',
      password: '',
      password_confirmation: ''
      }

    post '/api/v1/users', params: user_input.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(response.body).to eq("{\"error\":[\"Password can't be blank\",\"Password can't be blank\"]}")
  end

  it 'cannot create a user with already existing email' do

    user_input = {
      email: 'gmail@gmail.com',
      password: 'password',
      password_confirmation: 'password'
      }

    post '/api/v1/users', params: user_input.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
     
    user_input = {
      email: 'gmail@gmail.com',
      password: 'password',
      password_confirmation: 'password'
      }

    post '/api/v1/users', params: user_input.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(response.body).to eq("{\"error\":[\"Email has already been taken\"]}")
  end

end