class Api::V1::Merchants::SearchController < ApplicationController
  def show
    results = search_results(params).first
    render json: MerchantSerializer.new(results)
  end

  def index
    results = search_results(params)
    render json: MerchantSerializer.new(results)
  end

  private

  def search_results(params)
    results = Merchant.all
    results = results.filter_by_id(params[:id]) if params[:id].present?
    results = results.filter_by_name(params[:name]) if params[:name].present?
    results = results.filter_by_created_at(params[:created_at]) if params[:created_at].present?
    results = results.filter_by_updated_at(params[:updated_at]) if params[:updated_at].present?
    results
  end
end
