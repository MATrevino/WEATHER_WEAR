class TeleportService  
  def self.urban_area_salaries(location)
    get_url("/api/urban_areas/slug:#{location}/salaries/")
  end

  private
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "https://api.teleport.org") do |faraday|
      faraday.params["key"] = ENV["TELEPORT_API_KEY"]
    end
  end
end