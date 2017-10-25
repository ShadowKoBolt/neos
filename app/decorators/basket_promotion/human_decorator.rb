# frozen_string_literal: true

class BasketPromotion::HumanDecorator < SimpleDelegator
  include ActionView::Helpers::NumberHelper

  def subtotal_in_currency
    number_to_currency subtotal_float, unit: '£'
  end

  def name
    promotion.name || promotion.code
  end

  private

  def subtotal_float
    subtotal.to_f / 100.0
  end
end
