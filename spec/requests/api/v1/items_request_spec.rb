require 'rails_helper'

RSpec.describe 'Items API' do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end

  it "can get item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item['id']).to eq(id)
  end

  it "can create a new item" do
    merchant_id = create(:merchant).id
    item_params = { name: "Saw", description: "I want to play a game", unit_price: 87.43, merchant_id: merchant_id }

    post '/api/v1/items', params: {item: item_params}
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
  end

  it "can update an exisiting item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Sledge" }

    patch "/api/v1/items/#{id}", params: { item: item_params }
    item = Item.find(id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq('Sledge')
  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
