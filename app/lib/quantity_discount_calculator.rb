# frozen_string_literal: true

class QuantityDiscountCalculator
  def initialize(basket)
    @basket = basket
  end

  def run
    Promotion.where(code: nil).map do |promotion|
      discount = promotion.subtotal(@basket.products_subtotal)
      discount * number_of_times_promotion_matches(promotion)
    end.sum
  end

  private

  def number_of_times_promotion_matches(promotion)
    promotion.items.map do |item|
      no_of_item_matches = @basket.items.select do |basket_item|
        basket_item.product == item.product
      end.map(&:quantity).sum
      (no_of_item_matches.to_f / item.quantity.to_f).to_i
    end.min
  end
end
