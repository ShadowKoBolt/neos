# frozen_string_literal: true

class Basket::CheckoutForm < Reform::Form
  model Basket

  collection :items

  properties :email, :line_1, :line_2, :line_3, :city, :region, :postcode, :country
  property :credit_card, virtual: true

  validates :items, length: { minimum: 1 }
  validates :email, presence: true, email: true
  validates :line_1, :postcode, :country, presence: true
  validates :credit_card, presence: true
end
