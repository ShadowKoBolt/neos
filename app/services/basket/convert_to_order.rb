# frozen_string_literal: true

class Basket::ConvertToOrder
  def initialize(basket)
    @basket = basket
  end

  def run
    ActiveRecord::Base.transaction do
      order = Order.create!(order_attributes)
      @basket.items.each do |item|
        OrderItem.create!(item_attributes(item).merge(order: order))
      end
      @basket.basket_promotions.each do |basket_promotion|
        OrderItem.create!(basket_promotion_attributes(basket_promotion).merge(order: order))
      end
      unless @basket.quantity_discount_subtotal.zero?
        OrderItem.create!(quantity_discount_attributes.merge(order: order))
      end
      @basket.destroy
      { success: true, order: order }
    end
  end

  private

  def order_attributes
    { email: @basket.email, address: @basket.address }
  end

  def item_attributes(item)
    { name: item.product.name, quantity: item.quantity, subtotal: item.subtotal,
      order_itemable: item }
  end

  def basket_promotion_attributes(basket_promotion)
    basket_promotion = BasketPromotion::HumanDecorator.new(basket_promotion)
    { name: basket_promotion.name, quantity: 1, subtotal: basket_promotion.subtotal,
      order_itemable: basket_promotion.promotion }
  end

  def quantity_discount_attributes
    { name: 'Quantity discount', quantity: 1, subtotal: @basket.quantity_discount_subtotal }
  end
end
