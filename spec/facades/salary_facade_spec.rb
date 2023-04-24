require 'rails_helper'

RSpec.describe 'salary facade' do
  describe 'class methods' do
    it '.salary_info', :vcr do
      VCR.use_cassette('salary_facade_salary_info') do
        destination = 'chicago'
        chicago_urban_id = 'dp3wn'

        response = SalaryFacade.salary_info(destination)
        binding.pry
      end
    end
  end
end