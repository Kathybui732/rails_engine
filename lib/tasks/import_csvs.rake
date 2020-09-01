require 'csv'

desc 'Import data from csv files'
task :import => [:environment] do

  puts 'Clearing database...'
  Transaction.destroy_all
  InvoiceItem.destroy_all
  Invoice.destroy_all
  Item.destroy_all
  Merchant.destroy_all
  Customer.destroy_all

  puts 'Importing customers...'
  CSV.foreach('./db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
    Customer.create!(row.to_h)
  end
  puts "#{Customer.count} Customers created"

  puts 'Importing merchants...'
  CSV.foreach('./db/data/merchants.csv', headers: true, header_converters: :symbol) do |row|
    Merchant.create!(row.to_h)
  end
  puts "#{Merchant.count} Merchants created"

  puts 'Importing items...'
  CSV.foreach('./db/data/items.csv', headers: true, header_converters: :symbol) do |row|
    Item.create!({
        id: row[:id],
        name: row[:name],
        description: row[:description],
        unit_price: row[:unit_price].to_f/100,
        merchant_id: row[:merchant_id],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      }
    )
  end
  puts "#{Item.count} Items created"

  puts 'Importing invoices...'
  CSV.foreach('./db/data/invoices.csv', headers: true, header_converters: :symbol) do |row|
    Invoice.create!(row.to_h)
  end
  puts "#{Invoice.count} Invoices created"

  puts 'Importing invoice items...'
  CSV.foreach('./db/data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
    InvoiceItem.create!({
      id: row[:id],
      item_id: row[:item_id],
      invoice_id: row[:invoice_id],
      quantity: row[:quantity],
      unit_price: row[:unit_price].to_f/100,
      created_at: row[:created_at],
      updated_at: row[:updated_at]
      }
    )
  end
  puts "#{InvoiceItem.count} InvoiceItems created"

  puts 'Importing transactions...'
  CSV.foreach('./db/data/transactions.csv', headers: true, header_converters: :symbol) do |row|
    Transaction.create!(row.to_h)
  end
  puts "#{Transaction.count} Transactions created"

  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

  puts "CSV successfully imported into database"
end
