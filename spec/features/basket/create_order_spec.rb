# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Basket - Create order items from basket', type: :feature do
  let!(:product1) { FactoryBot.create(:product) }
  let!(:product2) { FactoryBot.create(:product) }

  before do
    visit root_path
  end

  it 'Complete an order' do
    add_product_to_basket(product1)
    add_product_to_basket(product1)
    add_product_to_basket(product2)
    complete_checkout_form
    click_button I18n.t('baskets.show.checkout')
    expect(page).to have_content("1 x #{product1.name} [£0.01]")
    expect(page).to have_content("2 x #{product2.name} [£0.02]")
  end
end
