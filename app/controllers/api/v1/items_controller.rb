class Api::V1::ItemsController < ApplicationController
  def index
    render json: Item.all
  end

  def show
    render json: Item.find(params[:id])
  end

  def create
    merchant = Merchant.find(params[:item][:merchant_id])
    render json: merchant.items.create!(item_params)
  end

  def update
    render json: Item.update(params[:id], item_params)
  end

  def destroy
    Item.destroy(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
