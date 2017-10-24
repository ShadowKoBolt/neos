# frozen_string_literal: true

class Product::HumanDecorator < SimpleDelegator
  include ActionView::Helpers::NumberHelper

  def price_in_currency
    number_to_currency price_float, unit: '£'
  end

  private

  def price_float
    price.to_f / 100.0
  end
end
