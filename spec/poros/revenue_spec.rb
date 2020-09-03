require 'rails_helper'

RSpec.describe 'Revenue' do
  it "is initialize with a revenue" do
    revenue = Revenue.new(10)
    expect(revenue.revenue).to eq(10)
  end
end
