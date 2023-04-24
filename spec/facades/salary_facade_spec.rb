require 'rails_helper'

RSpec.describe 'salary facade' do
  describe 'class methods' do
    it '.salary_info', :vcr do
      VCR.use_cassette('salary_facade_salary_info') do
        location = 'chicago'

        response = SalaryFacade.salary_info(location)
        binding.pry
      end
    end
  end
end