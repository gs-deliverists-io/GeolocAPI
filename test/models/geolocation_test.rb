require "test_helper"

class GeolocationTest < ActiveSupport::TestCase

  test "should be valid" do
    assert geolocations(:hamburg).valid?
  end

  test "ip should be present" do
    geo = geolocations(:hamburg)
    geo.ip = ""
    assert_not geo.valid?
  end
end
