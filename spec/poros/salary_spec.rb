require 'rails_helper'

RSpec.describe 'Salary poro' do
  describe 'class methods' do
    it 'returns a salary object' do
      VCR.use_cassette('salary_for_chicago') do
        response = SalaryFacade.salary_info('chicago')

        expect(response).to be_a(Salary)
        expect(response.id).to eq('null')
        expect(response.type).to eq('salaries')
        expect(response.destination).to eq('Chicago')
        expect(response.forecast.keys).to eq([:summary, :temperature])
        expect(response.salary.first.keys).to eq([:title, :min, :max])
        expect(response.salary.size).to eq(7)
      end
    end
  end
end