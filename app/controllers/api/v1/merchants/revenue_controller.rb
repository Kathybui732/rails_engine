class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: RevenueSerializer(Merchant.find(params[:merchant_id]).revenue)
  end
end
