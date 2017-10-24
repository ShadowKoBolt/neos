# frozen_string_literal: true

class Basket < ApplicationRecord
  has_many :items, as: :itemable
end
