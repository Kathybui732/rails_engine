class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    if params[:quantity].to_i <= Merchant.count && params[:quantity].to_i.positive?
      render json: MerchantSerializer.new(Merchant.most_items(params[:quantity].to_i))
    elsif params[:quantity].to_i >= Merchant.count && params[:quantity].to_i.positive?
      render json: MerchantSerializer.new(Merchant.most_items(Merchant.count))
    end
  end
end
