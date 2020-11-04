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

### Here is one set of full CRUD functionality endpoints. To see all endpoints available, please checkout my docs here!
- The base URL for this application is ``

### GET /merchants
For a list of all merchants recorded in the database

**response**
```json
{
    "data": [
        {
            "id": "1",
            "type": "merchant",
            "attributes": {
                "name": "Schroeder-Jerde"
            }
        },
        {
            "id": "2",
            "type": "merchant",
            "attributes": {
                "name": "Klein, Rempel and Jones"
            }
        }
    ]
}
```

### GET /merchants/1
For information about a specific merchant

```json
{
    "data": {
        "id": "1",
        "type": "merchant",
        "attributes": {
            "name": "Schroeder-Jerde"
        }
    }
}
```

### POST /merchants
To create a new merchant

**Body**
```json
{
  "name": "New Merchant"
}
```

**Response**
```json
{
    "data": {
        "id": "101",
        "type": "merchant",
        "attributes": {
            "name": "New Merchant"
        }
    }
}
```

### Patch /merchants/101
To update information about a merchant

```json
{
  "name": "New Name"
}
```

**Response**
```json
{
    "data": {
        "id": "101",
        "type": "merchant",
        "attributes": {
            "name": "New Name"
        }
    }
}
```

### Delete /merchants/101
To delete a merchant record

This endpoint returns a 204, No Content.


### Sad paths/Edge cases considered, not exucuted
- Response needs:
- to be accounted for when users enter something other than a number for an id when making a get request
- Users entering in multiple params
- Get requests for a merchant's show page that does not exist should return 204/404 status response
- The search queries using dates have to be entered in exactly a format such as this: '2012-03-27 14:53:59 UTC' - could tweak filter method to allow for other date syntaxes to work
- Destroy methods destroy the record of the merchant or item, direct dependencies are accounted for, but secondary connections are not accounted for. Some records might be left with empty merchant or item ID numbers.
- Sometimes the queries return with no results, this usually just returns an empty JSON - equivilent to 204?
