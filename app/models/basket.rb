# frozen_string_literal: true

class Basket < ApplicationRecord
  has_many :items, as: :itemable, dependent: :destroy
  has_many :basket_promotions, dependent: :destroy

  # TODO: specs that these should return HIGH PERCENT,
  # THEN LOW PERCENT, THEN FLAT AMOUNTS in any order
  has_many :promotions, through: :basket_promotions

  # TODO: specs
  has_many :code_promotions,
           -> { where.not(code: nil) },
           source: :promotion,
           class_name: 'Promotion',
           through: :basket_promotions

  # TODO: specs
  store :address, accessors: %i[line_1 line_2 line_3 city region postcode country]

  def products_subtotal
    items.map(&:subtotal).sum
  end

  def discounts_subtotal
    basket_promotions.map(&:subtotal).sum
  end

  def quantity_discount_subtotal
    QuantityDiscountCalculator.new(self).run
  end

  def subtotal
    [(products_subtotal + discounts_subtotal + quantity_discount_subtotal), 0].max
  end
end
