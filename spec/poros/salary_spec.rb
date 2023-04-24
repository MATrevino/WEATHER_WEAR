require 'rails_helper'

RSpec.describe 'Salary poro' do
  describe 'class methods' do
    it 'returns a salary object' do
      VCR.use_cassette('salary_for_chicago') do
        response = SalaryFacade.salary_info('chicago')
      end
    end
  end
end