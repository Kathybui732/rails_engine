require 'rails_helper'

RSpec.describe 'Merchant API' do
  it "can send a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end

  it "can find a merchant" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['id']).to eq(id)
  end

  it "can create a merchant" do
    merchant_params = { name: "New Merchant" }

    post '/api/v1/merchants', params: { merchant: merchant_params }
    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it "can update a merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: 'Updated Name' }

    patch "/api/v1/merchants/#{id}", params: { merchant: merchant_params }
    merchant = Merchant.find(id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it "can destroy a merchant" do
    merchant_id = create(:merchant).id

    expect(Merchant.count).to eq(1)
    expect{ delete "/api/v1/merchants/#{merchant_id}" }.to change(Merchant, :count).by(-1)
    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant_id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
