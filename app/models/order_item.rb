# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :order_itemable, polymorphic: true, optional: true

  validates :name, :quantity, :subtotal, presence: true
end
