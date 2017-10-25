# frozen_string_literal: true

module BasketHelper
  def add_product_to_basket(product)
    within "#product-#{product.id}" do
      click_button I18n.t('add_to_basket')
    end
  end

  def add_promotion_to_basket(promotion)
    within '#promo-form' do
      fill_in 'promotion[code]', with: promotion.code
      click_button I18n.t('add_promotional_code')
    end
  end

  def complete_checkout_form
    within '#checkout-form' do
      fill_in 'basket_email', with: 'email@example.com'
      fill_in 'basket_line_1', with: '1'
      fill_in 'basket_postcode', with: 'p'
      fill_in 'basket_country', with: 'c'
      fill_in 'basket_credit_card', with: '4242 4242 4242 4242'
    end
  end
end
