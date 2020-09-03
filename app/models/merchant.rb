class Merchant < ApplicationRecord
  include Filterable
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices

  def revenue
    Invoice.joins(:transactions).where("transactions.result = 'success' and invoices.status = 'shipped'").joins(:invoice_items).sum('invoice_items.quantity * invoice_items.unit_price')
  end
  
  scope :filter_by_name, ->(name) { where('lower(name) like ?', "%#{name.downcase}%") }
  scope :filter_by_id, ->(id) { where id: id }
  scope :filter_by_created_at, ->(created_at) { where('Date(created_at) = ?', created_at.to_s) }
  scope :filter_by_updated_at, ->(updated_at) { where('Date(updated_at) = ?', updated_at.to_s) }

  def self.most_revenue(limit)
    Merchant.joins(invoices:[:invoice_items, :transactions]).select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as revenue").where("transactions.result='success' and invoices.status='shipped'").group("merchants.id").order("revenue desc").limit(limit)
  end

  def self.most_items(limit)
    Merchant.joins(invoices:[:invoice_items, :transactions]).select("merchants.*, sum(invoice_items.quantity) as items_sold").where("transactions.result='success' and invoices.status='shipped'").group("merchants.id").order("items_sold desc").limit(limit)
  end
end
