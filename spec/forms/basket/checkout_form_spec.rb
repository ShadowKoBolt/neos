# frozen_string_literal: true

require 'rails_helper'

describe Basket::CheckoutForm do
  describe '#validate' do
    subject(:validate) { form.validate(params) }

    let(:form) { described_class.new(basket) }
    let(:basket) { FactoryBot.create(:basket) }

    context 'with valid params and items' do
      before do
        basket.items << FactoryBot.build(:item)
      end

      let(:params) do
        { email: 'valid@example.com', line_1: 'line 1', postcode: 'postcode',
          country: 'country', credit_card: '1234 1234 1234 1234' }
      end

      it { is_expected.to eq(true) }
      it { expect { validate }.not_to change { form.errors.any? }.from(false) }
    end

    context 'with no items' do
      let(:params) do
        { email: 'invalid', line_1: 'line 1', postcode: 'postcode',
          country: 'country', credit_card: '1234 1234 1234 1234' }
      end

      it { is_expected.to eq(false) }
      it { expect { validate }.to change { form.errors.any? }.from(false).to(true) }
    end

    context 'with invalid email' do
      before do
        basket.items << FactoryBot.build(:item)
      end

      let(:params) { { email: 'bademail', line_1: 'line 1', postcode: 'postcode', country: 'country' } }

      it { is_expected.to eq(false) }
      it { expect { validate }.to change { form.errors.any? }.from(false).to(true) }
    end

    context 'with no email' do
      before do
        basket.items << FactoryBot.build(:item)
      end

      let(:params) do
        { line_1: 'line 1', postcode: 'postcode',
          country: 'country', credit_card: '1234 1234 1234 1234' }
      end

      it { is_expected.to eq(false) }
      it { expect { validate }.to change { form.errors.any? }.from(false).to(true) }
    end

    context 'with missing address' do
      before do
        basket.items << FactoryBot.build(:item)
      end

      let(:params) do
        { email: 'valid@example.com', postcode: 'postcode',
          country: 'country', credit_card: '1234 1234 1234 1234' }
      end

      it { is_expected.to eq(false) }
      it { expect { validate }.to change { form.errors.any? }.from(false).to(true) }
    end

    context 'with missing credit card' do
      before do
        basket.items << FactoryBot.build(:item)
      end

      let(:params) do
        { email: 'valid@example.com', line_1: 'line 1', postcode: 'postcode', country: 'country' }
      end

      it { is_expected.to eq(false) }
      it { expect { validate }.to change { form.errors.any? }.from(false).to(true) }
    end
  end
end
