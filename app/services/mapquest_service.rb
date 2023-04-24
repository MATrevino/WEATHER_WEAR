require 'faraday'

class MapquestService
  def self.get_lat_long(location)
    get_url("/geocoding/v1/address?key=#{ENV["MAPQ_API_KEY"]}&location=#{location}")
  end

  def self.get_directions(origin, destination)
    get_url("/directions/v2/route?key=#{ENV["MAPQ_API_KEY"]}&from=#{origin}&to=#{destination}")
  end
  private

  def self.conn
    Faraday.new(url: "http://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = ENV["MAPQ_API_KEY"]
    end
  end
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end