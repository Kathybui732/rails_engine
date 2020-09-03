class Api::V1::RevenueController < ApplicationController
  def index
    render json: RevenueSerializer.new(RevenueFacade.total_revenue(params[:start], params[:end]))
  end

  def show
    merchant = Merchant.find(params[:merchant_id])
    render json: RevenueSerializer.new(RevenueFacade.revenue(merchant.revenue))
  end
end
