class Item < ApplicationRecord
  validates :name, :description, :unit_price, presence: true

  belongs_to :merchant, dependent: :nullify
  has_many :invoice_items, dependent: :nullify
  has_many :invoices, through: :invoice_items
end
