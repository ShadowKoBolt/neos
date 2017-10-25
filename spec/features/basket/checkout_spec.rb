# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Basket - Required checkout fields', type: :feature do
  let!(:product) { FactoryBot.create(:product) }

  before do
    visit root_path
  end

  it 'Skip email' do
    add_product_to_basket(product)
    complete_checkout_form
    within '#checkout-form' do
      fill_in 'basket_email', with: ''
    end
    click_button I18n.t('baskets.show.checkout')
    expect(page).to have_content("Email can't be blank")
  end

  it 'Skip address' do
    add_product_to_basket(product)
    complete_checkout_form
    within '#checkout-form' do
      fill_in 'basket_line_1', with: ''
    end
    click_button I18n.t('baskets.show.checkout')
    expect(page).to have_content("Line 1 can't be blank")
  end

  it 'Skip credit card' do
    add_product_to_basket(product)
    complete_checkout_form
    within '#checkout-form' do
      fill_in 'basket_credit_card', with: ''
    end
    click_button I18n.t('baskets.show.checkout')
    expect(page).to have_content("Credit card can't be blank")
  end
end
