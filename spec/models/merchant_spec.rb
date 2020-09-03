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

  describe 'most_revenue  ' do
    it "#revenue" do
      m1, m2, m3 = create_list(:merchant, 3)
      it1 = create(:item, merchant_id: m1.id)
      it2 = create(:item, merchant_id: m2.id)
      it3 = create(:item, merchant_id: m3.id)
      in1 = create(:invoice, merchant_id: m1.id, status: 'shipped')
      in2 = create(:invoice, merchant_id: m2.id, status: 'shipped')
      in3 = create(:invoice, merchant_id: m3.id, status: 'shipped')
      ii1 = create(:invoice_item, invoice_id: in1.id, item_id: it1.id, quantity: 1, unit_price: 10 )
      ii2 = create(:invoice_item, invoice_id: in2.id, item_id: it2.id, quantity: 2, unit_price: 20 )
      ii3 = create(:invoice_item, invoice_id: in3.id, item_id: it3.id, quantity: 3, unit_price: 30 )
      t1 = create(:transaction, invoice_id: in1.id, result: 'success', created_at: '2012-03-25 14:53:59 UTC' )
      t2 = create(:transaction, invoice_id: in2.id, result: 'success', created_at: '2012-03-26 14:53:59 UTC' )
      t3 = create(:transaction, invoice_id: in3.id, result: 'success', created_at: '2012-03-26 14:53:59 UTC' )

      expect(Merchant.most_revenue(1)).to eq([m3])
    end

    it "#most_items" do
      m1, m2, m3 = create_list(:merchant, 3)
      it1 = create(:item, merchant_id: m1.id)
      it2 = create(:item, merchant_id: m2.id)
      it3 = create(:item, merchant_id: m3.id)
      in1 = create(:invoice, merchant_id: m1.id, status: 'shipped')
      in2 = create(:invoice, merchant_id: m2.id, status: 'shipped')
      in3 = create(:invoice, merchant_id: m3.id, status: 'shipped')
      ii1 = create(:invoice_item, invoice_id: in1.id, item_id: it1.id, quantity: 1, unit_price: 10 )
      ii2 = create(:invoice_item, invoice_id: in2.id, item_id: it2.id, quantity: 2, unit_price: 20 )
      ii3 = create(:invoice_item, invoice_id: in3.id, item_id: it3.id, quantity: 3, unit_price: 30 )
      t1 = create(:transaction, invoice_id: in1.id, result: 'success', created_at: '2012-03-25 14:53:59 UTC' )
      t2 = create(:transaction, invoice_id: in2.id, result: 'success', created_at: '2012-03-26 14:53:59 UTC' )
      t3 = create(:transaction, invoice_id: in3.id, result: 'success', created_at: '2012-03-26 14:53:59 UTC' )

      expect(Merchant.most_items(1)).to eq([m3])
    end
  end
end
