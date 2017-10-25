# frozen_string_literal: true

require 'rails_helper'

describe Item::HumanDecorator do
  describe '#subtotal_in_currency' do
    subject { described_class.new(item).subtotal_in_currency }

    let(:item) { instance_double('Item', subtotal: 1000) }

    it { is_expected.to eq('£10.00') }
  end
end
