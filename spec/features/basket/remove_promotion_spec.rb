# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Basket - Add Promotion', type: :feature do
  let!(:product) { Product.create(name: 'Product one', price: 1000) }
  let!(:promotion) { FactoryBot.create(:promotion, name: 'Promo one', conjunction: true) }

  before do
    visit root_path
  end

  it 'Remove promotion' do
    add_product_to_basket(product)
    add_promotion_to_basket(promotion)
    remove_promotion_from_basket(promotion)
    within '#basket' do
      expect(page).not_to have_content('Promo one')
    end
  end

  def remove_promotion_from_basket(promotion)
    within "#basket-promotion-promotion-#{promotion.id}" do
      click_button I18n.t('baskets.show.remove')
    end
  end
end
