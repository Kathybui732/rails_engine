require 'rails_helper'

RSpec.describe 'Merchant API' do
  it "can send a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].size).to eq(3)
    expect(merchants[:data][0]).to have_key(:id)
    expect(merchants[:data][0]).to have_key(:type)
    expect(merchants[:data][0]).to have_key(:attributes)
    expect(merchants[:data][0][:attributes]).to have_key(:name)
  end

  it "can find a merchant" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant_json = JSON.parse(response.body, symbolize_names: true)
    merchant = Merchant.find(id)

    expect(response).to be_successful
    expect(merchant_json[:data][:id]).to eq("#{id}")
    expect(merchant_json[:data][:type]).to eq('merchant')
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)

  end

  it "can create a merchant" do
    merchant_params = { name: "New Merchant" }

    post '/api/v1/merchants', params: { merchant: merchant_params }
    merchant = Merchant.last
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
    expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_json[:data][:type]).to eq('merchant')
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end

  it "can update a merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: 'Updated Name' }

    patch "/api/v1/merchants/#{id}", params: { merchant: merchant_params }
    merchant = Merchant.find(id)
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq(merchant_params[:name])
    expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_json[:data][:type]).to eq('merchant')
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant_params[:name])
  end

  it "can destroy a merchant" do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)
    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_json[:data][:type]).to eq('merchant')
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
