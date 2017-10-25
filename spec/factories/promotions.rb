# frozen_string_literal: true

FactoryBot.define do
  factory :promotion do
    discount_type Promotion::FLAT_AMOUNT
    discount_amount 1000
    sequence(:code) { |i| "code-#{i}" }
  end
end
