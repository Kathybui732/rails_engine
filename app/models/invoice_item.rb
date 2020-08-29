class InvoiceItem < ApplicationRecord
  validates :quantity, :unit_price, presence: true

  belongs_to :invoice, dependent: :destroy
  belongs_to :item, dependent: :destroy
end
