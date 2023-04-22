require 'rails_helper'

RSpec.describe 'MapquestService' do
  describe 'class methods' do
    it 'returns the lat and long for denver' do
      binding.pry
      MapquestService.get_lat_long('denver,co')
      response = File.read('spec/fixtures/denver_ll.json')


        binding.pry
      expect(response).to have_http_status(200)
      
      location = JSON.parse(response.body, symbolize_names: true)
      
      expect(location.keys).to eq([:results])
      expect(location[:results].keys).to eq([:providedLocation, :locations])
      expect(location[:results][:providedLocation].keys).to eq([:location])
      expect(location[:results][:locations].keys).to eq([:street, :adminArea6, :adminArea6Type, :adminArea5, :adminArea5Type, :adminArea4, :adminArea4Type, :adminArea3, :adminArea3Type, :adminArea1, :adminArea1Type, :postalCode, :geocodeQualityCode, :geocodeQuality, :dragPoint, :sideOfStreet, :linkId, :unknownInput, :type, :latLng, :displayLatLng, :mapUrl])
      expect(location[:results][:locations][:latLng].keys).to eq([:lat, :lng])
    end
  end
end