class Geolocation < ApplicationRecord
  validates :original_ip_or_url, presence: true
  validates :ip, presence: true
end
