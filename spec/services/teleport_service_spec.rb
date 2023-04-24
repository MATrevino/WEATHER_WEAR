require 'rails_helper'

RSpec.describe 'TeleportService' do
  describe 'class methods' do
    it '.urban_area_salaries', :vcr do
      VCR.use_cassette('teleport_get_urban_area_salaries') do
        location = 'chicago'

        response = TeleportService.urban_area_salaries(location)
        
        expect(response).to be_a(Hash)
        expect(response.keys).to eq([:_links, :salaries])
      end
    end
  end
end