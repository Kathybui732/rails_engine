require 'rails_helper'

RSpec.describe 'Multi items finder feature' do
  describe 'As a user' do
    it "can provide a list of items based on a name query" do
      create_list(:item, 5, name: "Hockey Puck")
      create(:item)
      name = "Hockey Puck"

      get "/api/v1/items/find_all?name=#{name}"
      items_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(items_json.class).to eq(Hash)
      expect(Item.count).to eq(6)
      expect(items_json[:data].size).to eq(5)
    end

    it "can provide a list of items based on a partial name query" do
      create_list(:item, 5, name: "Hockey Puck")
      create(:item)
      name = "HOC"

      get "/api/v1/items/find_all?name=#{name}"
      items_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(items_json.class).to eq(Hash)
      expect(Item.count).to eq(6)
      expect(items_json[:data].size).to eq(5)
    end

    it "can provide a list of items based on a description query" do
      create_list(:item, 5, description: "Plus one to your offense")
      create(:item)
      description = "Plus one to your offense"

      get "/api/v1/items/find_all?description=#{description}"
      items_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(items_json.class).to eq(Hash)
      expect(Item.count).to eq(6)
      expect(items_json[:data].size).to eq(5)
    end

    it "can provide a list of items based on a unit_price query" do
      create_list(:item, 5, unit_price: 90.78)
      create(:item)
      unit_price = 90.78

      get "/api/v1/items/find_all?unit_price=#{unit_price}"
      items_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(items_json.class).to eq(Hash)
      expect(Item.count).to eq(6)
      expect(items_json[:data].size).to eq(5)
    end

    it "can provide a list of items based on a merchant_id query" do
      merchants = create_list(:merchant, 2)
      create_list(:item, 5, merchant_id: merchants.first.id)
      create(:item, merchant_id: merchants.last.id)
      merchant_id = merchants.first.id

      get "/api/v1/items/find_all?merchant_id=#{merchant_id}"
      items_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(items_json.class).to eq(Hash)
      expect(Item.count).to eq(6)
      expect(items_json[:data].size).to eq(5)
    end

    it "can provide a list of items based on a created_at query" do
      items = create_list(:item, 5)
      create(:item, created_at: DateTime.parse("2020-09-01 00:06:49 UTC"))
      created_at = items.first.created_at

      get "/api/v1/items/find_all?created_at=#{created_at}"
      items_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(items_json.class).to eq(Hash)
      expect(Item.count).to eq(6)
      expect(items_json[:data].size).to eq(5)
    end

    it "can provide a list of items based on a updated_at query" do
      items = create_list(:item, 5)
      create(:item, updated_at: DateTime.parse("2020-09-01 00:06:49 UTC"))
      updated_at = items.first.updated_at

      get "/api/v1/items/find_all?updated_at=#{updated_at}"
      items_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      expect(items_json.class).to eq(Hash)
      expect(Item.count).to eq(6)
      expect(items_json[:data].size).to eq(5)
    end
  end
end
