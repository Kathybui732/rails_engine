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
      expect(Merchant.count).to eq(6)
      expect(items_json[:data].size).to eq(5)
    end
  end
end
