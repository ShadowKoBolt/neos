# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Basket - Remove Items', type: :feature do
  let!(:product) { Product.create(name: 'Product one', price: 1) }

  before do
    visit root_path
  end

  it 'Remove item from basket' do
    add_product_to_basket(product)
    remove_product_from_basket(product)
    within '#basket' do
      expect(page).not_to have_content('1Product one')
    end
  end

  it 'Reduce quantity of item in basket' do
    add_product_to_basket(product)
    add_product_to_basket(product)
    remove_product_from_basket(product)
    within '#basket' do
      expect(page).to have_content('1Product one')
    end
  end

  def remove_product_from_basket(product)
    within "#basket-item-product-#{product.id}" do
      click_button I18n.t('remove_from_basket')
    end
  end
end
