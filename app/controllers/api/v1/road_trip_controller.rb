class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if params[:origin].present? == false || params[:destination].present? == false
      render json: {error: "Origin and destination are required fields"}, status: 400
    elsif params[:origin] == params[:destination]
      render json: {error: "Origin and destination cannot be the same"}, status: 400
    elsif user && params[:origin] && params[:destination] && params[:origin] != params[:destination]
      RoadtripFacade.travel_info(params[:origin], params[:destination]).class == Roadtrip
      roadtrip = RoadtripFacade.travel_info(params[:origin], params[:destination])
      render json: RoadtripSerializer.new(roadtrip), status: 201
    elsif params[:api_key] != User.find_by(api_key: params[:api_key])
      render json: {error: "API key is invalid"}, status: 400
    end
  end
end