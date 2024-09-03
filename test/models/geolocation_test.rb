require "test_helper"

class GeolocationTest < ActiveSupport::TestCase
  test "should be valid" do
    assert geolocations(:google).valid?
  end

  test "ip should be present" do
    geo = geolocations(:google)
    geo.ip = ""
    assert_not geo.valid?
  end

  test "original_ip_or_url should be present" do
    geo = geolocations(:google)
    geo.original_ip_or_url = ""
    assert_not geo.valid?
  end
end
