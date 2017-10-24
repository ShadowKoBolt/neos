# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    product
    quantity 1
    association :itemable, factory: :basket
  end
end
