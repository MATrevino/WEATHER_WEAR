require 'rails_helper'

RSpec.describe 'salary facade' do
  describe 'class methods' do
    it '.salary_info', :vcr do
      VCR.use_cassette('salary_facade_salary_info') do
        location = 'chicago'

        response = SalaryFacade.salary_info(location)
        expect(response).to be_a(Salary)
        expect(response.destination).to eq(location)
        expect(response.forecast.keys).to eq([:summary, :temperature])
        expect(response.salary.first.keys).to eq([:title, :min, :max])
        expect(response.salary.first[:title]).to eq("Data Analyst")
      end
    end
  end
end