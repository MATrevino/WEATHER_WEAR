class SalaryController < ApplicationController
  def index
    binding.pry
    #params[:location]
    @salary = Salary.find_by_location(params[:location])
    render json: @salary
  end
end