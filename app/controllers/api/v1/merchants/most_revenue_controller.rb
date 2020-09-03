class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    if params[:quantity].to_i <= Merchant.count && params[:quantity].to_i.positive?
      render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity].to_i))
    elsif params[:quantity].to_i >= Merchant.count && params[:quantity].to_i.positive?
      render json: MerchantSerializer.new(Merchant.most_revenue(Merchant.count))
    end
  end
end
