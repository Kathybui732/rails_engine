class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices

  scope :filter_by_name, ->(name) { where('lower(name) like ?', "%#{name.downcase}%") }
  scope :filter_by_id, ->(id) { where id: id }
  scope :filter_by_created_at, ->(created_at) { where('Date(created_at) = ?', created_at.to_s) }
  scope :filter_by_updated_at, ->(updated_at) { where('Date(updated_at) = ?', updated_at.to_s) }

  def self.find_merchant(params_hash)
    find_by("#{params_hash[:key]}": params_hash[:value])
  end
end
