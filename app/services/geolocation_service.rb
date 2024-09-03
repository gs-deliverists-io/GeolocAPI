require "httparty"
require "uri"

class GeolocationService
  include HTTParty
  base_uri "http://api.ipstack.com"

  def initialize(ip_or_url)
    @ip = resolve_to_ip(ip_or_url)
    @access_key = ENV["IPSTACK_API_KEY"]
  end

  def fetch_data
    return unless @ip

    response = self.class.get("/#{@ip}", query: { access_key: @access_key })
    JSON.parse(response.body).symbolize_keys if response.success?
  end

  def resolve_to_ip(ip_or_url)
    return ip_or_url if ip_or_url =~ Resolv::IPv4::Regex

    uri = URI.parse(ip_or_url)
    hostname = uri.host || uri.path

    begin
      Resolv.getaddress(hostname)
    rescue Resolv::ResolvError
      nil
    end
  end
end
