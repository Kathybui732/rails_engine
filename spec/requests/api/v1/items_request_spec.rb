require 'rails_helper'

RSpec.describe 'Items API' do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].size).to eq(3)
    expect(items[:data][0]).to have_key(:id)
    expect(items[:data][0]).to have_key(:type)
    expect(items[:data][0][:attributes]).to have_key(:name)
    expect(items[:data][0][:attributes]).to have_key(:description)
    expect(items[:data][0][:attributes]).to have_key(:unit_price)
  end

  it "can get item by its id" do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item_json[:data][:id]).to eq("#{item.id}")
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:attributes][:name]).to eq(item.name)
    expect(item_json[:data][:attributes][:description]).to eq(item.description)
    expect(item_json[:data][:attributes][:unit_price]).to eq(item.unit_price)
  end

  it "can create a new item" do
    merchant_id = create(:merchant).id
    item_params = { name: "Saw", description: "I want to play a game", unit_price: 87.43, merchant_id: merchant_id }

    post '/api/v1/items', params: {item: item_params}
    item = Item.last
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
    expect(item_json[:data][:id]).to eq("#{item.id}")
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:attributes][:name]).to eq(item_params[:name])
    expect(item_json[:data][:attributes][:description]).to eq(item_params[:description])
    expect(item_json[:data][:attributes][:unit_price]).to eq(item_params[:unit_price])

  end

  it "can update an exisiting item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Sledge" }

    patch "/api/v1/items/#{id}", params: { item: item_params }
    item = Item.find(id)
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq(item_params[:name])
    expect(item_json[:data][:id]).to eq("#{id}")
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:attributes][:name]).to eq(item_params[:name])
    expect(item_json[:data][:attributes][:description]).to eq(item.description)
    expect(item_json[:data][:attributes][:unit_price]).to eq(item.unit_price)
  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)
    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)
    item_json = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(item_json[:data][:id]).to eq("#{item.id}")
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:attributes][:name]).to eq(item.name)
    expect(item_json[:data][:attributes][:description]).to eq(item.description)
    expect(item_json[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
