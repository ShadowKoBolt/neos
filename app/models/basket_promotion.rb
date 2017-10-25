# frozen_string_literal: true

class BasketPromotion < ApplicationRecord
  belongs_to :basket
  belongs_to :promotion

  def subtotal
    promotion.subtotal(basket.products_subtotal + basket.quantity_discount_subtotal)
  end
end
