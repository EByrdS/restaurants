# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show update destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
  end

  # GET /restaurants/123abc
  # GET /restaurants/123abc.json
  def show; end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      render :show, status: :created, location: @restaurant
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /restaurants/123abc
  # PATCH/PUT /restaurants/123abc.json
  def update
    if @restaurant.update(restaurant_params.except(:local_id))
      render :show, status: :ok, location: @restaurant
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /restaurants/123abc
  # DELETE /restaurants/112abc.json
  def destroy
    @restaurant.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find_by_local_id!(params[:local_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def restaurant_params
    params.require(:restaurant).permit(:local_id, :rating, :name, :site, :email, :phone, :street, :city, :state, :lat, :lng)
  end
end
