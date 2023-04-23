class Api::V1::ForecastController < ApplicationController
  def index
    location = params[:location]
    forecast = ForecastFacade.forecast(location)
    
    if Forecast.valid_location?(location)
      render json: ForecastSerializer.new(forecast)
    else 
      render json: {error: 'Invalid Location'}, status: :bad_request
    end
  end
end