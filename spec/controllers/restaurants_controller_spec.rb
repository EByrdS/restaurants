# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe RestaurantsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Restaurant. As you add validations to Restaurant, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { attributes_for :restaurant }

  let(:invalid_attributes) { attributes_for :invalid_restaurant }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RestaurantsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      Restaurant.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      restaurant = Restaurant.create! valid_attributes
      get :show, params: { local_id: restaurant.to_param },
                 session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Restaurant' do
        expect do
          post :create, params: { restaurant: valid_attributes },
                        session: valid_session
        end.to change(Restaurant, :count).by(1)
      end

      it 'renders a JSON response with the new restaurant' do
        post :create, params: { restaurant: valid_attributes },
                      session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(restaurant_url(Restaurant.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new restaurant' do
        post :create, params: { restaurant: invalid_attributes },
                      session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { attributes_for(:restaurant) }

      it 'updates the requested restaurant' do
        restaurant = Restaurant.create! valid_attributes
        put :update, params: { local_id: restaurant.to_param,
                               restaurant: new_attributes },
                     session: valid_session
        restaurant.reload
        expect(restaurant.attributes
                 .symbolize_keys.except(:id, :local_id, :lonlat, :created_at,
                                        :updated_at, :lat, :lng))
          .to eq new_attributes.except(:local_id, :lat, :lng)
        expect(restaurant.lat).to be_within(1e-8).of new_attributes[:lat]
        expect(restaurant.lng).to be_within(1e-8).of new_attributes[:lng]
        expect(restaurant.local_id).to eq valid_attributes[:local_id]
      end

      it 'renders a JSON response with the restaurant' do
        restaurant = Restaurant.create! valid_attributes

        put :update, params: { local_id: restaurant.to_param,
                               restaurant: valid_attributes },
                     session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the restaurant' do
        restaurant = Restaurant.create! valid_attributes

        put :update, params: { local_id: restaurant.to_param,
                               restaurant: invalid_attributes },
                     session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested restaurant' do
      restaurant = Restaurant.create! valid_attributes
      expect do
        delete :destroy, params: { local_id: restaurant.to_param },
                         session: valid_session
      end.to change(Restaurant, :count).by(-1)
    end
  end

  describe 'GET #statistics' do
    it 'shows JSON for nearby restaurants' do
      restaurant = Restaurant.create! valid_attributes
      get :statistics, params: { latitude: restaurant.lat,
                                 longitude: restaurant.lng,
                                 radius: 1 }, session: valid_session
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      hash_body = JSON.parse(response.body)
      expect(hash_body).to include 'count', 'avg', 'std'
      expect(hash_body['count']).to eq 1
      expect(hash_body['avg']).to eq restaurant.rating
      expect(hash_body['std']).to eq 0
    end
  end
end
