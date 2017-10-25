# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Basket - Add Items', type: :feature do
  let!(:product1) { Product.create(name: 'Product one', price: 1) }
  let!(:product2) { Product.create(name: 'Product two', price: 1) }

  before do
    visit root_path
  end

  it 'Add item to basket' do
    add_product_to_basket(product1)
    within '#basket' do
      expect(page).to have_content('1Product one')
    end
  end

  it 'Add second item to basket' do
    add_product_to_basket(product1)
    add_product_to_basket(product2)
    within '#basket' do
      expect(page).to have_content('1Product one')
      expect(page).to have_content('1Product one')
    end
  end

  it 'Many of item to basket' do
    add_product_to_basket(product1)
    add_product_to_basket(product1)
    within '#basket' do
      expect(page).to have_content('2Product one')
    end
  end
end
