class AddOriginalIpOrUrlToGeolocations < ActiveRecord::Migration[8.0]
  def change
    add_column :geolocations, :original_ip_or_url, :string
  end
end
