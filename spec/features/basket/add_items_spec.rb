# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Basket - Add Items', type: :feature do
  let!(:product_1) { Product.create(name: 'Product one', price: 1) }

  before do
    visit root_path
  end

  it 'Add first item to basket' do
    add_product_to_basket(product_1)
    within '#basket' do
      expect(page).to have_content('1 x Product one')
    end
  end

  it 'Add second item to basket' do
    add_product_to_basket(product_1)
    add_product_to_basket(product_1)
    within '#basket' do
      expect(page).to have_content('2 x Product one')
    end
  end

  def add_product_to_basket(product)
    within "#product-#{product.id}" do
      click_button I18n.t('add_to_basket')
    end
  end
end
