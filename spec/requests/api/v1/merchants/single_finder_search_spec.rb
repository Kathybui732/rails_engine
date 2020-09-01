require 'rails_helper'

RSpec.describe 'Single find feature' do
  it 'can return a single result based on a name query param' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")
    expect(merchant_json.class).to eq(Hash)
    expect(merchant_json.size).to eq(1)

    expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_json[:data][:type]).to eq('merchant')
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'can return a single result based on a name query param even if there are two of that same param' do
    merchant = Merchant.create(name: "King Soopers")
    merchant_2 = Merchant.create(name: "King Soopers")

    get "/api/v1/merchants/find?name=King Soopers"
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(Merchant.count).to eq(2)
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")
    expect(merchant_json.class).to eq(Hash)
    expect(merchant_json.size).to eq(1)
    expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_json[:data][:id]).to_not eq("#{merchant_2.id}")
    expect(merchant_json[:data][:type]).to eq('merchant')
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'can return a single result based on a created at query param' do
    merchant = Merchant.create!(id: '1', name: 'Schroeder-Jerde', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')
    created_at = merchant.created_at.to_s

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")
    expect(merchant_json.class).to eq(Hash)
    expect(merchant_json.size).to eq(1)
    expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_json[:data][:type]).to eq('merchant')
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'can return a single result based on a updated at query param' do
    merchant = Merchant.create!(id: '1', name: 'Schroeder-Jerde', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')

    get "/api/v1/merchants/find?created_at=#{merchant.updated_at}"
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")
    expect(merchant_json.class).to eq(Hash)
    expect(merchant_json.size).to eq(1)
    expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_json[:data][:type]).to eq('merchant')
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'can return a single result based on a name that is a fragment and lower case' do
    merchant = Merchant.create(name: "King Soopers")
    name = 'SOOPERS'

    get "/api/v1/merchants/find?name=#{name}"
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")
    expect(merchant_json.class).to eq(Hash)
    expect(merchant_json.size).to eq(1)
    expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_json[:data][:type]).to eq('merchant')
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end
end
