require 'rails_helper'

RSpec.describe 'TeleportService' do
  describe 'class methods' do
    # it '.get_ua_id', :vcr do
    #   VCR.use_cassette('teleport_get_ua_id for Chicago') do
    #     destination = 'chicago'

    #     response = TeleportService.get_ua_id(destination)
    #   end
    # end
    it '.urban_area_salaries', :vcr do
      VCR.use_cassette('teleport_get_urban_area_salaries') do
        destination = 'chicago'

        chicago_urban_id = 'dp3wn'

        response = TeleportService.urban_area_salaries(chicago_urban_id)
        
        expect(response).to be_a(Hash)
        expect(response.salaries).to be_an(Array)
      end
    end
  end
end