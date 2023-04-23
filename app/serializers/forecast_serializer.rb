class ForecastSerializer
include JSONAPI::Serializer
set_type :forecast
  attributes :current_weather, :daily_weather, :hourly_weather

end