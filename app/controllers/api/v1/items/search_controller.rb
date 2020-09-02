class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(search_results(params).first)
  end

  def index
    render json: ItemSerializer.new(search_results(params))
  end

  private

  def search_results(params)
    Item.filter(params.slice(:name, :id, :description, :unit_price, :merchant_id, :created_at, :updated_at))
  end
end
