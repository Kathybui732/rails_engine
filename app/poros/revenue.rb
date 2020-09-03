class Revenue
  attr_reader :revenue

  def initialize(revenue)
    @revenue = revenue
  end

  def self.total_revenue_date_range(start_date, end_date)
    beginning = Date.parse(start_date).beginning_of_day
    end_of_day = Date.parse(end_date).end_of_day

    total_rev = Invoice.joins(:invoice_items, :transactions.where("'date(invoices.created_at) BETWEEN ? AND ?', beginning, end_of_day and transactions.result = 'success' and invoices.status = 'shipped'").sum('quantity * unit_price')

    new(total_revenue)
  end
end
