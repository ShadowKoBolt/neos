# frozen_string_literal: true

require 'rails_helper'

describe Basket::HumanDecorator do
  describe '#items' do
    subject { described_class.new(basket).items }

    let(:basket) { FactoryBot.build(:basket, items: items) }
    let(:items) { FactoryBot.build_list(:item, 2) }

    it { is_expected.to all(be_a(Item::HumanDecorator)) }
  end

  describe '#basket_promotions' do
    subject { described_class.new(basket).basket_promotions }

    let(:basket) { FactoryBot.build(:basket, basket_promotions: basket_promotions) }
    let(:basket_promotions) { FactoryBot.build_list(:basket_promotion, 2) }

    it { is_expected.to all(be_a(BasketPromotion::HumanDecorator)) }
  end

  describe '#subtotal_in_currency' do
    subject { described_class.new(basket).subtotal_in_currency }

    let(:basket) { instance_double('Basket', subtotal: 1000) }

    it { is_expected.to eq('£10.00') }
  end

  describe '#quantity_discount_subtotal_in_currency' do
    subject { described_class.new(basket).quantity_discount_subtotal_in_currency }

    let(:basket) { instance_double('Basket', quantity_discount_subtotal: 1000) }

    it { is_expected.to eq('£10.00') }
  end
end
