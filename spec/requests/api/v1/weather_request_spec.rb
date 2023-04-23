require 'rails_helper'

RSpec.describe 'receive forecast for a city' do
  describe 'get /api/v1/forecast?location=#{location}' do
    
    location = 'denver,co'
    before { get "/api/v1/forecast?location=#{location}" }
    it 'returns a forecast for a city' do

    
      expect(response).to be_successful
    end
  end
end