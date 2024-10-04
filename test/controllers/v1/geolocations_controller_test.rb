require "test_helper"
require "minitest/autorun"

class V1::GeolocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @geolocation = geolocations(:google)
    @headers = { "Authorization" => ENV["API_TOKEN"] }
  end

  test "should get geolocation" do
    get v1_geolocation_url(@geolocation)
    assert_response :success
  end

  test "should return unprocessable_entity when GeolocationService returns nil" do
    mock = Minitest::Mock.new
    def mock.fetch_data; nil; end

    GeolocationService.stub :new, mock do
      post v1_geolocations_url, params: { geolocation: { ip_or_url: "https://google.com" } }, headers: @headers
    end
    assert_nil assigns(:geo_data)
    assert_response :unprocessable_entity
  end

  #  test "should create geolocation with valid token" do
  #    VCR.use_cassette("geolocation_google_com") do
  #      post v1_geolocations_url, params: { geolocation: { ip_or_url: "https://google.com" } }, headers: @headers
  #      assert_response :created
  #    end
  #  end

  test "should not create geolocation without valid token" do
    post v1_geolocations_url, params: { geolocation: { ip_or_url: "134.201.250.155" } }
    assert_response :unauthorized
  end

  test "should delete geolocation with valid token" do
    delete v1_geolocation_url(@geolocation), headers: @headers
    assert_response :success
  end

  test "should response with not_found when geolocation is not found" do
    delete v1_geolocation_url(5), headers: @headers
    assert_response :not_found
  end


  test "should not delete geolocation without valid token" do
    delete v1_geolocation_url(@geolocation)
    assert_response :unauthorized
  end
end
