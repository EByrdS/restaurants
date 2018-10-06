# frozen_string_literal: true

json.extract! restaurant, :id, :local_id, :rating, :name, :site, :email, :phone, :street, :city, :state, :lat, :lng, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
