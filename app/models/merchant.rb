class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :nullify
  has_many :invoices, dependent: :nullify
  has_many :transactions, through: :invoices
end
