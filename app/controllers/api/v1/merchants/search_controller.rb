class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(search_results(params).first)
  end

  def index
    render json: MerchantSerializer.new(search_results(params))
  end

  private

  def search_results(params)
    Merchant.filter(params.slice(:name, :id, :created_at, :updated_at))
  end
end
