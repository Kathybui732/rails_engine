require 'rails_helper'

RSpec.describe 'Multi merchants finder feature' do
  describe 'As a user' do
    it "can provide a list of merchants based on a name query" do
      merchants = 5.times do
        Merchant.create(name: "King Soopers")
      end
      create(:merchant)
      name = "King Soopers"

      get "/api/v1/merchants/find_all?name=#{name}"

      expect(response).to be_successful
      merchants_json = JSON.parse(response.body, symbolize_names: true)
      expect(response.content_type).to eq("application/json")
      expect(Merchant.count).to eq(6)
      expect(merchants_json.class).to eq(Hash)
      expect(merchants_json[:data].size).to eq(5)
    end

    it "can provide a list of merchants based on a part of the name query" do
      merchants = 5.times do
        Merchant.create(name: "King Soopers")
      end
      create(:merchant)
      name = "KIN"

      get "/api/v1/merchants/find_all?name=#{name}"

      expect(response).to be_successful
      merchants_json = JSON.parse(response.body, symbolize_names: true)
      expect(response.content_type).to eq("application/json")
      expect(Merchant.count).to eq(6)
      expect(merchants_json.class).to eq(Hash)
      expect(merchants_json[:data].size).to eq(5)
    end

    it "can provide a list of merchants based on created at query" do
      merchants = create_list(:merchant, 5)
      Merchant.create(name: "King Soopers", created_at: DateTime.parse("2020-09-01 00:06:49 UTC"))
      created_at = merchants.first.created_at

      get "/api/v1/merchants/find_all?created_at=#{created_at}"

      expect(response).to be_successful
      merchants_json = JSON.parse(response.body, symbolize_names: true)
      expect(response.content_type).to eq("application/json")
      expect(Merchant.count).to eq(6)
      expect(merchants_json.class).to eq(Hash)
      expect(merchants_json[:data].size).to eq(5)
    end

    it "can provide a list of merchants based on updated at query" do
      merchants = create_list(:merchant, 5)
      Merchant.create(name: "King Soopers", updated_at: DateTime.parse("2020-09-01 00:06:49 UTC"))
      updated_at = merchants.first.updated_at

      get "/api/v1/merchants/find_all?updated_at=#{updated_at}"

      expect(response).to be_successful
      merchants_json = JSON.parse(response.body, symbolize_names: true)
      expect(response.content_type).to eq("application/json")
      expect(Merchant.count).to eq(6)
      expect(merchants_json.class).to eq(Hash)
      expect(merchants_json[:data].size).to eq(5)
    end
  end
end
