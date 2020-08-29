class InvoiceItem < ApplicationRecord
  validates :quantity, :unit_price, presence: true

  belongs_to :invoice, dependent: :nullify
  belongs_to :item, dependent: :nullify
end
