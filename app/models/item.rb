# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :product
  belongs_to :itemable, polymorphic: true

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def subtotal
    product.price * quantity
  end
end
