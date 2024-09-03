require "httparty"
require "uri"

class GeolocationService
  include HTTParty
  base_uri "http://api.ipstack.com"

  def initialize(ip_or_url)
    @ip = resolve_to_ip(ip_or_url)
    @access_key = ENV["IPSTACK_API_KEY"]
    # @access_key = 'kotek'
  end

  def fetch_data
    return unless @ip
    response = self.class.get("/#{@ip}", query: { access_key: @access_key })
    parsed_response = parse_response(response)

    if parsed_response[:success] == false
      error_message = parsed_response[:error] || "Unknown error"
      raise StandardError.new("API request failed: #{error_message}")
    end
    parsed_response
  end

  def resolve_to_ip(ip_or_url)
    return ip_or_url if ip_or_url =~ Resolv::IPv4::Regex

    uri = URI.parse(ip_or_url)
    hostname = uri.host || uri.path

    Resolv.getaddress(hostname)
  rescue Resolv::ResolvError
    nil
  end

  private

  def parse_response(response)
    JSON.parse(response.body).symbolize_keys
  end
end
