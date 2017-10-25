# frozen_string_literal: true

class Basket::HumanDecorator < SimpleDelegator
  include ActionView::Helpers::NumberHelper

  def items
    super.map { |item| Item::HumanDecorator.new(item) }
  end

  def basket_promotions
    super.map { |basket_promotion| BasketPromotion::HumanDecorator.new(basket_promotion) }
  end

  def subtotal_in_currency
    number_to_currency subtotal_float, unit: '£'
  end

  def quantity_discount_subtotal_in_currency
    number_to_currency quantity_discount_subtotal_float, unit: '£'
  end

  private

  def subtotal_float
    subtotal.to_f / 100.0
  end

  def quantity_discount_subtotal_float
    quantity_discount_subtotal.to_f / 100.0
  end
end
