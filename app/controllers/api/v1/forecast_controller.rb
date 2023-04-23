class Api::V1::ForecastController < ApplicationController
  def index
    if params[:location].present?
      forecast = ForecastFacade.forecast(params[:location])
      render json: ForecastSerializer.new(forecast)
    else 
      render json: {error: 'Invalid Location'}, status: :bad_request
    end
  end
end