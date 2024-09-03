class Geolocation < ApplicationRecord
  validates :ip, presence: true
end
