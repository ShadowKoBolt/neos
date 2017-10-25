# frozen_string_literal: true

class Basket::AddPromotionService
  def initialize(basket, promotion)
    @basket = basket
    @promotion = promotion
  end

  def run
    if promotion_valid_in_basket?(@promotion, @basket)
      @basket.basket_promotions.create(promotion: @promotion)
      true
    else
      false
    end
  end

  private

  def promotion_valid_in_basket?(promotion, basket)
    return false if promotion.in?(basket.promotions)
    return false if !promotion.conjunction && basket.code_promotions.any?
    return false if basket.code_promotions.map { |existing_promotion| !existing_promotion.conjunction }.any?
    true
  end
end
