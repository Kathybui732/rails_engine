class Transaction < ApplicationRecord
  validates :credit_card_number, :result, presence: true

  belongs_to :invoice, dependent: :nullify
end
