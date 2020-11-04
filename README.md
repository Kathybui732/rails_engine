# README

# Rails Engine
Rails engine is a backend E-commerce application providing full CRUD functionality API endpoints for Merchants and their Items following the ReST principles. This application provides a total of 28 endpoints including:
  - 20 ReST endpoints for merchants and items as well as their relational endpoints
  - 2 endpoints for the '/find' search capabilities to return a single item/merchant finder under one param query
  - 2 endpoints for the '/find_all' also a search feature that will it returns a list of merchant/items
  - 1 endpoints for the 'merchants/most_revenue' that takes in a quantity param that will return an endpoint with the top x number of merchants with the most revenue
  - 1 endpoints for the '/merchants/most_items' which also takes in a quantity param, but will return the top x merchants who have sold the most items
  - 1 endpoints for the '/revenue' which takes in two date params and will return an endpoint with the total revenue across all merchants during that time period
  - 1 endpoints for the '/merchants/:id/revenue' returns an endpoint with the revenue of a single merchant
  Endpoints were constructed using Active record.

 ### Ruby Version
 Ruby 2.5.3
 Rails 5.2.4.3

 ### Configuration
1. `git clone git@github.com:Kathybui732/rails_engine.git`
2. `cd rails_engine`
3. `bundle install`
4. `rake db:{create,migrate}`
5. `bundle exec rake import` to seed your database
6. `bundle exec rspec` to run the test suite

### CRUD ENDPOINTS FOLLOWING REST PRICIPLES
Create


Read


Update


Destroy


### Additional Endpoints
Find


Find_all


Single finder - Merchant


Multi finder - Merchant


Most Revenue


Most Items


Merchant Revenue


Total Revenue over a time period

### Sad paths/Edge cases considered, not executed
- Response needs:
- to be accounted for when users enter something other than a number for an id when making a get request
- Users entering in multiple params
- Get requests for a merchant's show page that does not exist should return 204/404 status response
- The search queries using dates have to be entered in exactly a format such as this: '2012-03-27 14:53:59 UTC' - could tweak filter method to allow for other date syntaxes to work
- Destroy methods destroy the record of the merchant or item, direct dependencies are accounted for, but secondary connections are not accounted for. Some records might be left with empty merchant or item ID numbers.
- Sometimes the queries return with no results, this usually just returns an empty JSON - equivilent to 204?
