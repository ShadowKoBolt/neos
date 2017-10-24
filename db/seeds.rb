# frozen_string_literal: true

{
  'Smart Hub' => 4999,
  'Motion Sensor' => 2499,
  'Wireless Camera' => 9999,
  'Smoke Sensor' => 1999,
  'Water Leak Sensor' => 1499
}.each do |name, price|
  Product.create(name: name, price: price)
end
