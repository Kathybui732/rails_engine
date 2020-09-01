require 'rails_helper'

RSpec.describe 'Merchant Items API' do
  it "can get a list of all items belonging to a merchant" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    item_2 = create(:item, merchant_id: merchant.id)
    item_3 = create(:item, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"
    items_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(items_json.class).to eq(Hash)
    expect(items_json[:data].size).to eq(3)
    expect(items_json[:data][0]).to have_key(:id)
    expect(items_json[:data][0]).to have_key(:type)
    expect(items_json[:data][0][:attributes]).to have_key(:name)
    expect(items_json[:data][0][:attributes]).to have_key(:description)
    expect(items_json[:data][0][:attributes]).to have_key(:unit_price)
  end
end
