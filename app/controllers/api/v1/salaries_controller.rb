class Api::V1::SalariesController < ApplicationController
  def index
    salary = SalaryFacade.salary_info(params[:destination].downcase)
    render json: SalariesSerializer.new(salary)
  end
end