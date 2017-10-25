# frozen_string_literal: true

require 'rails_helper'

describe QuantityDiscountCalculator do
  describe '#run' do
    subject { described_class.new(basket).run }

    let(:basket) { FactoryBot.build_stubbed(:basket) }

    context 'with no promotions' do
      it { is_expected.to eq(0) }
    end

    context 'with promotion' do
      let(:product) { FactoryBot.build(:product, price: 2) }

      before do
        FactoryBot.create(:promotion, code: nil, discount_type: Promotion::FLAT_AMOUNT, discount_amount: 1,
                                      items: [FactoryBot.create(:item, product: product, quantity: 2)])
      end

      context 'with basket which is not elligable' do
        before do
          basket.items << FactoryBot.build(:item, product: product, quantity: 1)
        end

        it { is_expected.to eq(0) }
      end

      context 'with a basket which is eligable' do
        before do
          basket.items << FactoryBot.build(:item, product: product, quantity: 2)
        end

        it { is_expected.to eq(-1) }
      end

      context 'with basket which is eligable multiple times' do
        before do
          basket.items << FactoryBot.build(:item, product: product, quantity: 5)
        end

        it { is_expected.to eq(-2) }
      end
    end
  end
end
