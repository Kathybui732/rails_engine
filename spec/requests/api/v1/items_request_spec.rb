require 'rails_helper'

RSpec.describe 'Items API' do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'
    items_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(items_json.class).to eq(Hash)
    expect(items_json[:data].size).to eq(3)
    expect(items_json[:data][0]).to have_key(:id)
    expect(items_json[:data][0]).to have_key(:type)
    expect(items_json[:data][0][:attributes]).to have_key(:name)
    expect(items_json[:data][0][:attributes]).to have_key(:description)
    expect(items_json[:data][0][:attributes]).to have_key(:unit_price)
    expect(items_json[:data][0][:attributes]).to have_key(:merchant_id)
  end

  it "can get item by its id" do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item_json.class).to eq(Hash)
    expect(item_json[:data][:id]).to eq("#{item.id}")
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:attributes][:name]).to eq(item.name)
    expect(item_json[:data][:attributes][:description]).to eq(item.description)
    expect(item_json[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(item_json[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it "can create a new item" do
    merchant_id = create(:merchant).id
    item_params = { name: "Saw", description: "I want to play a game", unit_price: 87.43, merchant_id: merchant_id }

    post '/api/v1/items', params: item_params

    item_json = JSON.parse(response.body, symbolize_names: true)
    item = Item.last

    expect(response).to be_successful
    expect(item_json.class).to eq(Hash)
    expect(item.name).to eq(item_params[:name])
    expect(item_json[:data][:id]).to eq("#{item.id}")
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:attributes][:name]).to eq(item_params[:name])
    expect(item_json[:data][:attributes][:description]).to eq(item_params[:description])
    expect(item_json[:data][:attributes][:unit_price]).to eq(item_params[:unit_price])
    expect(item_json[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it "can update an exisiting item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Sledge" }

    patch "/api/v1/items/#{id}", params: item_params
    item = Item.find(id)
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item_json.class).to eq(Hash)
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq(item_params[:name])
    expect(item_json[:data][:id]).to eq("#{id}")
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:attributes][:name]).to eq(item_params[:name])
    expect(item_json[:data][:attributes][:description]).to eq(item.description)
    expect(item_json[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(item_json[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)
    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response.status).to eq(204)
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
