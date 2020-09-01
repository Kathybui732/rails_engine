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

  describe 'methods' do
    it "#find_merchant" do
      merchant = create(:merchant)
      params_hash = {
        key: 'name',
        value: merchant.name
      }
      expect(Merchant.find_merchant(params_hash)).to eq(merchant)
    end
  end
end
