require 'rails_helper'

RSpec.describe 'receive salary info for a city' do
  describe 'provides salary info for given location' do
    it 'returns salary info for a given city' do
      VCR.use_cassette('salary_for_chicago') do
        destination = 'chicago'

        get '/api/v1/salary?destination=chicago'

        data = JSON.parse(response.body, symbolize_names: true)

        binding.pry
      end
    end
  end
end