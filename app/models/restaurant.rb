# frozen_string_literal: true

# :nodoc:
class Restaurant < ApplicationRecord
  validates :rating, inclusion: { in: [0, 1, 2, 3, 4],
                                  message: '%{value} is not a valid rating' }
  validates :lat, presence: true
  validates :lng, presence: true
  validates :local_id, presence: true
  scope :within, lambda { |latitude, longitude, meters_distance|
    where(format(%{
     ST_Distance(lonlat, 'POINT(%f %f)') < %d
    }, longitude, latitude, meters_distance)) # Default unit for geographic type
  }

  before_save :create_geographic_point

  def to_param
    local_id
  end

  private

  def create_geographic_point
    return unless lat_changed? || lng_changed?

    self.lonlat = "POINT(#{lng} #{lat})"
  end
end
