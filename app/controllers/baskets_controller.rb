# frozen_string_literal: true

class BasketsController < ApplicationController
  def show
    @basket = current_basket
    @products = Product.all.map { |product| Product::HumanDecorator.new(product) }
  end
end
