# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:itemable) }

  it { is_expected.to validate_presence_of(:quantity) }
  it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than(0) }

  describe '#subtotal' do
    subject { item.subtotal }

    let(:product) { FactoryBot.build(:product, price: 1000) }
    let(:item) { FactoryBot.build(:item, quantity: 2, product: product) }

    it { is_expected.to eq(2000) }
  end
end
