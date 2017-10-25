# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BasketPromotion, type: :model do
  it { is_expected.to belong_to(:basket) }
  it { is_expected.to belong_to(:promotion) }

  describe '#subtotal' do
    subject { basket_promotion.subtotal }

    let(:basket_promotion) { FactoryBot.build(:basket_promotion, promotion: promotion, basket: basket) }
    let(:basket) { FactoryBot.build_stubbed(:basket) }

    context 'flat amount' do
      let(:promotion) { FactoryBot.build(:promotion, discount_type: Promotion::FLAT_AMOUNT, discount_amount: 1) }

      it { is_expected.to eq(-1) }
    end

    context 'percent' do
      let(:promotion) { FactoryBot.build(:promotion, discount_type: Promotion::PERCENT, discount_amount: 50) }

      before do
        allow(basket).to receive(:products_subtotal).and_return(10)
      end

      it { is_expected.to eq(-5) }
    end
  end
end
