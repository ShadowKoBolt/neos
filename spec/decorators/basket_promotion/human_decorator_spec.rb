# frozen_string_literal: true

require 'rails_helper'

describe BasketPromotion::HumanDecorator do
  describe '#subtotal_in_currency' do
    subject { described_class.new(basket_promotion).subtotal_in_currency }

    let(:basket_promotion) { instance_double('BasketPromotion', subtotal: 1000) }

    it { is_expected.to eq('£10.00') }
  end

  describe '#name' do
    subject { described_class.new(basket_promotion).name }

    let(:basket_promotion) { FactoryBot.build_stubbed(:basket_promotion, promotion: promotion) }

    context 'promotion with name' do
      let(:promotion) { FactoryBot.build_stubbed(:promotion, name: 'foo') }

      it { is_expected.to eq('foo') }
    end

    context 'promotion with code and no name' do
      let(:promotion) { FactoryBot.build_stubbed(:promotion, name: nil, code: 'bar') }

      it { is_expected.to eq('bar') }
    end
  end
end
