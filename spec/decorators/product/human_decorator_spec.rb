# frozen_string_literal: true

require 'rails_helper'

describe Product::HumanDecorator do
  describe '#price_in_currency' do
    subject { described_class.new(product).price_in_currency }

    let(:product) { Product.new(price: 1000) }

    it { is_expected.to eq('£10.00') }
  end
end
