# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Basket - Total price calculated', type: :feature do
  let!(:product1) { Product.create(name: 'Product one', price: 100) }
  let!(:product2) { Product.create(name: 'Product two', price: 200) }

  before do
    visit root_path
  end

  it 'Check total' do
    add_product_to_basket(product1)
    within '#basket' do
      expect(page).to have_content('Subtotal£1.00')
    end
  end

  it 'Check total on multiple items' do
    add_product_to_basket(product1)
    add_product_to_basket(product2)
    within '#basket' do
      expect(page).to have_content('Subtotal£3.00')
    end
  end

  it 'Check total on multiple quantities' do
    add_product_to_basket(product1)
    add_product_to_basket(product1)
    within '#basket' do
      expect(page).to have_content('Subtotal£2.00')
    end
  end

  it 'Check total with quantity discount' do
    promotion = FactoryBot.create(:promotion, code: nil, discount_amount: 50)
    FactoryBot.create(:item, itemable: promotion, quantity: 2, product: product1)
    add_product_to_basket(product1)
    add_product_to_basket(product1)
    within '#basket' do
      expect(page).to have_content('Subtotal£1.50')
    end
  end

  it 'Check total with multiple quantity discount' do
    promotion = FactoryBot.create(:promotion, code: nil, discount_amount: 50)
    FactoryBot.create(:item, itemable: promotion, quantity: 2, product: product1)
    4.times { add_product_to_basket(product1) }
    within '#basket' do
      expect(page).to have_content('Subtotal£3.00')
    end
  end

  it 'Check total with flat amount disount' do
    promotion = FactoryBot.create(:promotion, discount_amount: 50)
    add_product_to_basket(product1)
    add_promotion_to_basket(promotion)
    within '#basket' do
      expect(page).to have_content('Subtotal£0.50')
    end
  end

  it 'Check total with percent discount' do
    promotion = FactoryBot.create(:promotion, discount_amount: 25, discount_type: Promotion::PERCENT)
    add_product_to_basket(product1)
    add_promotion_to_basket(promotion)
    within '#basket' do
      expect(page).to have_content('Subtotal£0.75')
    end
  end

  it 'Check total with flat amount discount and percent discount' do
    promotion1 = FactoryBot.create(:promotion, discount_amount: 50, conjunction: true)
    promotion2 = FactoryBot.create(:promotion, discount_amount: 25, discount_type: Promotion::PERCENT, conjunction: true)
    add_product_to_basket(product1)
    add_promotion_to_basket(promotion1)
    add_promotion_to_basket(promotion2)
    within '#basket' do
      expect(page).to have_content('Subtotal£0.25')
    end
  end
end
