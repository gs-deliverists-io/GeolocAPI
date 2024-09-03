require "httparty"

class GeolocationService
  include HTTParty
  base_uri "http://api.ipstack.com"

  def initialize(ip_or_url)
    @ip_or_url = ip_or_url
    @access_key = ENV["IPSTACK_API_KEY"]
  end

  def fetch_data
    response = self.class.get("/#{@ip_or_url}", query: { access_key: @access_key })
    JSON.parse(response.body) if response.success?
  end
end
