class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :unit_price

  has_one :merchant
end
