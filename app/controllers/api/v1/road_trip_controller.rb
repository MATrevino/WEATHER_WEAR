class Api::V1::RoadTripController < ApplicationController
  def create
    roadtrip = RoadtripFacade.travel_info(params[:origin], params[:destination])
      render json: RoadtripSerializer.new(roadtrip), status: 201
    # else
    #   render json: {error: roadtrip.errors.full_messages }, status: 400
    # end
  end
end