# frozen_string_literal: true

FactoryBot.define do
  alphanumeric = ('a'..'z').to_a + ('0'..'9').to_a

  factory :restaurant do
    local_id do
      [
        (0..8).map { alphanumeric.sample }.join,
        (0..4).map { alphanumeric.sample }.join,
        (0..4).map { alphanumeric.sample }.join,
        (0..4).map { alphanumeric.sample }.join,
        (0..12).map { alphanumeric.sample }.join
      ].join('-')
    end
    rating { (0..4).to_a.sample }
    name { FFaker::Company.name }
    site { FFaker::Internet.http_url }
    email { FFaker::Internet.safe_email }
    phone { FFaker::PhoneNumber.short_phone_number }
    street { FFaker::Address.street_name }
    city { FFaker::Address.city }
    state { FFaker::AddressUS.state }
    lat { rand * (20 - 19) + 19 }
    lng { rand * (-100 - -99) + -99 }
  end

  trait :no_id do
    local_id { nil }
  end

  trait :bad_rating do
    rating { (5..10).to_a.sample }
  end

  factory :invalid_restaurant, parent: :restaurant, traits: %i[no_id bad_rating]
end
