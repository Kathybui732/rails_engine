require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
  end

  # describe 'methods' do
  #
  #   it "#revenue" do
  #     merchants = create_list(:merchant, 2)
  #     merchant = merchants.first
  #     item_1 = create(:item, merchant_id: merchants.first.id)
  #     item_2 = create(:item, merchant_id: merchants.first.id)
  #     items_2 = create_list(:item, 2, merchant_id: merchants.last.id)
  #     invoices = create_list(:invoice, 2, merchant_id: merchants.first.id)
  #     ii1 = create(:invoice_item, invoice_id: invoices.first.id, item_id: item_1.id)
  #     ii2 = create(:invoice_item, invoice_id: invoices.last.id, item_id: item_2.id)
  #     create(:transaction, invoice_id: invoices.first.id, result: 'success')
  #     create(:transaction, invoice_id: invoices.last.id, result: 'success')
  #     expected = (ii1.quantity * ii1.unit_price) + (ii2.quantity * ii2.unit_price)
  #     expect(merchant.revenue).to eq(expected)
  #   end
  # end
end
