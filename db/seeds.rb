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

Promotion.create(code: '20%OFF', discount_type: Promotion::PERCENT, discount_amount: 20, conjunction: false)
Promotion.create(code: '5%OFF', discount_type: Promotion::PERCENT, discount_amount: 5, conjunction: true)
Promotion.create(code: '5POUNDSOFF', discount_type: Promotion::FLAT_AMOUNT, discount_amount: 500, conjunction: true)

Promotion.create(discount_type: Promotion::FLAT_AMOUNT, discount_amount: 997)
         .items << Item.create(quantity: 3, product: Product.find_by_name('Motion Sensor'))

Promotion.create(discount_type: Promotion::FLAT_AMOUNT, discount_amount: 498)
         .items << Item.create(quantity: 2, product: Product.find_by_name('Smoke Sensor'))
