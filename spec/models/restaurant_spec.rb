# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it 'creates POINT before save' do
    restaurant = build :restaurant
    expect(restaurant.lonlat).to be_nil
    restaurant.save
    expect(restaurant.lonlat).to_not be_nil
    expect(restaurant.lonlat).to be_a RGeo::Geographic::SphericalPointImpl
    expect(restaurant).to be_valid
  end

  it 'has POINT after creation' do
    restaurant = create :restaurant
    expect(restaurant.lonlat).to_not be_nil
  end
end
