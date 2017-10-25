# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Basket, type: :model do
  it { is_expected.to have_many(:items).dependent(:destroy) }
  it { is_expected.to have_many(:basket_promotions).dependent(:destroy) }
  it { is_expected.to have_many(:promotions) }
  it { is_expected.to have_many(:code_promotions) }

  describe '#products_subtotal' do
    subject { basket.products_subtotal }

    let(:basket) { FactoryBot.build(:basket) }

    context 'no items' do
      it { is_expected.to eq(0) }
    end

    context 'with items' do
      before do
        item1 = FactoryBot.build(:item)
        item2 = FactoryBot.build(:item)
        allow(item1).to receive(:subtotal).and_return(1500)
        allow(item2).to receive(:subtotal).and_return(500)
        basket.items = [item1, item2]
      end
      it { is_expected.to eq(2000) }
    end
  end

  describe '#discounts_subtotal' do
    subject { basket.discounts_subtotal }

    let(:basket) { FactoryBot.build_stubbed(:basket) }

    context 'no discount' do
      it { is_expected.to eq(0) }
    end

    context 'with discounts' do
      before do
        discount1 = FactoryBot.build(:basket_promotion)
        discount2 = FactoryBot.build(:basket_promotion)
        allow(discount1).to receive(:subtotal).and_return(-1)
        allow(discount2).to receive(:subtotal).and_return(-2)
        basket.basket_promotions = [discount1, discount2]
      end

      it { is_expected.to eq(-3) }
    end
  end

  describe '#quantity_discount_subtotal' do
    subject { basket.quantity_discount_subtotal }

    let(:basket) { FactoryBot.build_stubbed(:basket) }

    before do
      allow(QuantityDiscountCalculator)
        .to receive(:new)
        .and_return(instance_double('QuantityDiscountCalculator', run: -1))
    end

    it { is_expected.to eq(-1) }
  end

  describe '#subtotal' do
    subject { basket.subtotal }

    let(:basket) { FactoryBot.build(:basket) }

    before do
      allow(basket).to receive(:products_subtotal).and_return(10)
      allow(basket).to receive(:discounts_subtotal).and_return(-5)
      allow(basket).to receive(:quantity_discount_subtotal).and_return(-2)
    end

    it { is_expected.to eq(3) }

    context 'discount greater than products subtotal' do
      before do
        allow(basket).to receive(:products_subtotal).and_return(10)
        allow(basket).to receive(:discounts_subtotal).and_return(-50)
      end

      it { is_expected.to eq(0) }
    end
  end
end
