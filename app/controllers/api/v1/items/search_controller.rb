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
    # results = results.filter_by_description(params[:description]) if params[:description].present?
    results = results.filter_by_unit_price(params[:unit_price]) if params[:unit_price].present?
    results = results.filter_by_merchant_id(params[:merchant_id]) if params[:merchant_id].present?
    results = results.filter_by_created_at(params[:created_at]) if params[:created_at].present?
    results
  end
end
