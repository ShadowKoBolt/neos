# frozen_string_literal: true

class Promotion < ApplicationRecord
  PERCENT = 'percent'
  FLAT_AMOUNT = 'flat_amount'

  has_many :basket_promotions, dependent: :destroy
  has_many :items, as: :itemable, dependent: :destroy

  validates :discount_type, inclusion: { in: [PERCENT, FLAT_AMOUNT] }
  validates :discount_amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :code, uniqueness: { allow_blank: true }

  def subtotal(total)
    case discount_type
    when Promotion::PERCENT
      percent_subtotal(total)
    when Promotion::FLAT_AMOUNT
      flat_amount_subtotal
    else
      0
    end
  end

  private

  def percent_subtotal(total)
    -((total.to_f / 100.0) * discount_amount.to_f).to_i
  end

  def flat_amount_subtotal
    -discount_amount
  end
end
