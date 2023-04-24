class SalariesSerializer
  include JSONAPI::Serializer
  attributes :destination, :forecast, :salary
end