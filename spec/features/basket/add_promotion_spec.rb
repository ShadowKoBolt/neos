# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Basket - Add Promotion', type: :feature do
  let!(:product) { Product.create(name: 'Product one', price: 1000) }
  let!(:promotion1) { FactoryBot.create(:promotion, name: 'Promo one', conjunction: true) }
  let!(:promotion2) { FactoryBot.create(:promotion, name: 'Promo two', conjunction: true) }

  before do
    FactoryBot.create(:promotion, code: nil, items: [FactoryBot.build(:item, product: product, quantity: 2)])
    visit root_path
  end

  it 'Add promotion' do
    add_product_to_basket(product)
    add_promotion_to_basket(promotion1)
    within '#basket' do
      expect(page).to have_content('Promo one')
    end
  end

  it 'Add multiple promotions' do
    add_product_to_basket(product)
    add_promotion_to_basket(promotion1)
    add_promotion_to_basket(promotion2)
    within '#basket' do
      expect(page).to have_content('Promo one')
      expect(page).to have_content('Promo two')
    end
  end

  it 'Add quantity promotion' do
    add_product_to_basket(product)
    add_product_to_basket(product)
    within '#basket' do
      expect(page).to have_content('Quantity Discount')
    end
  end
end
