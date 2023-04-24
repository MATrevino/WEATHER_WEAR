class Api::V1::SalaryController < ApplicationController
  def index
    salary = SalaryFacade.salary_info(params[:destination])
    render json: SalariesSerializer.new(salary)
  end
end