require "test_helper"

class GeolocationServiceTest < ActiveSupport::TestCase
  test "fetches geolocation data based on IP" do
    VCR.use_cassette("geolocation_ip") do
      service = GeolocationService.new("134.201.250.155")
      result = service.fetch_data

      assert result[:country_name], "Result should include country name"
      assert result[:city], "Result should include city"
      assert result[:latitude], "Result should include latitude"
      assert result[:longitude], "Result should include longitude"
    end
  end

  test "fetches geolocation data based on URL" do
    VCR.use_cassette("geolocation_www_google_com") do
      service = GeolocationService.new("www.google.com")
      result = service.fetch_data

      assert result[:country_name], "Result should include country name"
      assert result[:city], "Result should include city"
      assert result[:latitude], "Result should include latitude"
      assert result[:longitude], "Result should include longitude"
    end
  end

  test "fetches geolocation data based on URL with https prefix" do
    VCR.use_cassette("geolocation_google_com") do
      service = GeolocationService.new("https://google.com")
      result = service.fetch_data

      assert result[:country_name], "Result should include country name"
      assert result[:city], "Result should include city"
      assert result[:latitude], "Result should include latitude"
      assert result[:longitude], "Result should include longitude"
    end
  end

  test "invalid access key" do
    VCR.use_cassette("geolocation_invalid_access_key") do
      service = GeolocationService.new("https://google.com")
      service.instance_variable_set(:@access_key, "invalid-key")
      assert_raise StandardError do
        service.fetch_data
      end
    end
  end
end
