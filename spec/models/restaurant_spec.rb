# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lng) }
    it { should validate_presence_of(:local_id) }
    it { should validate_inclusion_of(:rating).in_array([0, 1, 2, 3, 4]) }
  end

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
