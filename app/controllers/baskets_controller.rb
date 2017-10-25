# frozen_string_literal: true

class BasketsController < ApplicationController
  before_action :load_products

  def show
    @basket = Basket::HumanDecorator.new(current_basket)
    @checkout_form = Basket::CheckoutForm.new(@basket)
  end

  def checkout
    @basket = Basket::HumanDecorator.new(current_basket)
    @checkout_form = Basket::CheckoutForm.new(current_basket)
    if @checkout_form.validate(checkout_params)
      result = Basket::ConvertToOrder.new(@checkout_form.sync).run
      @order = result[:order]
    else
      render action: :show
    end
  end

  private

  def load_products
    @products = Product.all.map { |product| Product::HumanDecorator.new(product) }
  end

  def checkout_params
    params.require(:basket).permit(:email, :line_1, :line_2, :line_3,
                                   :city, :region, :postcode, :country, :credit_card)
  end
end
