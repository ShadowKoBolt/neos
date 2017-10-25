# frozen_string_literal: true

class Order < ApplicationRecord
  # TODO: specs
  has_many :order_items, dependent: :destroy

  # TODO: specs
  store :address, accessors: %i[line_1 line_2 line_3 city region postcode country]
end
