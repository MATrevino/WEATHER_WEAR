require 'rails_helper'

RSpec.describe 'TeleportService' do
  describe 'class methods' do
    it '.urban_area_salaries', :vcr do
      VCR.use_cassette('teleport_get_urban_area_salaries') do
        
        urban_area = ''

        response = TeleportService.urban_area_salaries(urban_area)
        
        expect(response).to be_a(Hash)
      end
    end
  end
end