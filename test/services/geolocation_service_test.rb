require "test_helper"

class GeolocationServiceTest < ActiveSupport::TestCase
  test "fetches geolocation data based on IP" do
    service = GeolocationService.new("134.201.250.155")
    result = service.fetch_data

    assert result["country_name"], "Result should include country name"
    assert result["city"], "Result should include city"
    assert result["latitude"], "Result should include latitude"
    assert result["longitude"], "Result should include longitude"
  end

  test "fetches geolocation data based on URL" do
    service = GeolocationService.new("www.google.com")
    result = service.fetch_data

    assert result["country_name"], "Result should include country name"
    assert result["city"], "Result should include city"
    assert result["latitude"], "Result should include latitude"
    assert result["longitude"], "Result should include longitude"
  end

  test "fetches geolocation data based on URL with https prefix" do
    service = GeolocationService.new("https://google.com")
    result = service.fetch_data

    assert result["country_name"], "Result should include country name"
    assert result["city"], "Result should include city"
    assert result["latitude"], "Result should include latitude"
    assert result["longitude"], "Result should include longitude"
  end


end
