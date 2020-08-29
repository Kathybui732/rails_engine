class Invoice < ApplicationRecord
  validates :status, presence: true

  belongs_to :customer, dependent: :nullify
  has_many :transactions, dependent: :nullify
  has_many :invoice_items, dependent: :nullify
  has_many :items, through: :invoice_items
  belongs_to :merchant, dependent: :nullify
end
