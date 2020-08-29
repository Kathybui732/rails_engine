class InvoiceItem < ApplicationRecord
  validates :quantity, :unit_price, presence: true
end
