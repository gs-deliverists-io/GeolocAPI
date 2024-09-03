module V1
  class GeolocationsController < ApplicationController
    before_action :authenticate_token!, only: [ :create, :destroy ]
    before_action :set_geolocation, only: [ :show, :destroy ]

    def show
      render json: @geolocation
    end

    def destroy
      if @geolocation.destroy
        render json: { message: "Geolocation successfully deleted" }, status: :ok
      else
        render json: { error: "Failed to delete geolocation" }, status: :unprocessable_entity
      end
    end

    def create
      geo_service = GeolocationService.new(geolocation_params[:ip_or_url])
      geo_data = geo_service.fetch_data

      if geo_data
        @geolocation = Geolocation.new(
          original_ip_or_url: geolocation_params[:ip_or_url],

          ip: geo_data[:ip],
          url: geo_data[:url],
          country: geo_data[:country_name],
          city: geo_data[:city],
          latitude: geo_data[:latitude],
          longitude: geo_data[:longitude]
        )

        if @geolocation.save
          render json: @geolocation, status: :created
        else
          render json: @geolocation.errors, status: :unprocessable_entity
        end
      else
        render json: { error: "Unable to fetch geolocation data" }, status: :unprocessable_entity
      end
    end

    private

    def set_geolocation
      @geolocation = Geolocation.find(params[:id])
    end

    def geolocation_params
      params.require(:geolocation).permit(:ip_or_url, :url)
    end

    def authenticate_token!
      render json: { error: "Unauthorized" }, status: :unauthorized unless valid_token?
    end

    def valid_token?
      request.headers["Authorization"] == ENV["API_TOKEN"]
    end
  end
end
