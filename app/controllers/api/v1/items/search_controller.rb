class Api::V1::Items::SearchController < ApplicationController
  def show
    results = search_results(params).first
    render json: ItemSerializer.new(results).serialized_json
  end

  private

  def search_results(params)
    results = Item.all
    results = results.filter_by_name(params[:name]) if params[:name].present?
    results = results.filter_by_id(params[:id]) if params[:id].present?
    results
  end
end
