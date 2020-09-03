require 'rails_helper'

RSpec.describe 'Specific merchants revenue' do
  it "can get a specific merchant's revenue" do
    merchants = create_list(:merchant, 2)
    merchant = merchants.first
    item_1 = create(:item, merchant_id: merchants.first.id)
    item_2 = create(:item, merchant_id: merchants.first.id)
    items_2 = create_list(:item, 2, merchant_id: merchants.last.id)
    invoices = create_list(:invoice, 2, merchant_id: merchants.first.id)
    ii1 = create(:invoice_item, invoice_id: invoices.first.id, item_id: item_1.id)
    ii2 = create(:invoice_item, invoice_id: invoices.last.id, item_id: item_2.id)
    create(:transaction, invoice_id: invoices.first.id, result: 'success')
    create(:transaction, invoice_id: invoices.last.id, result: 'success')
    expected = (ii1.quantity * ii1.unit_price) + (ii2.quantity * ii2.unit_price)

    get "/api/v1/merchants/#{merchant.id}/revenue"
    revenue_json = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')
    expect(revenue_json[:data]).to have_key(:id)
    expect(revenue_json[:data]).to have_key(:attributes)
    expect(revenue_json[:data][:attributes]).to have_key(:revenue)
    expect(revenue_json[:data][:id]).to eq(nil)
    expect(revenue_json[:data][:attributes][:revenue]).to eq(expected)
  end
end
