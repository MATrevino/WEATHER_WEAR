class ForecastSerializer
include JSONAPI::Serializer
  attributes :id, 
            :type, 
            :attributes

end