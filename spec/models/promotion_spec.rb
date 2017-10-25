# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Promotion, type: :model do
  it { is_expected.to have_many(:basket_promotions).dependent(:destroy) }
  it { is_expected.to have_many(:items).dependent(:destroy) }

  it { is_expected.to validate_inclusion_of(:discount_type).in_array(%w[percent flat_amount]) }
  it { is_expected.to validate_presence_of(:discount_amount) }
  it { is_expected.to validate_numericality_of(:discount_amount).only_integer.is_greater_than(0) }
  it { is_expected.to validate_uniqueness_of(:code).allow_blank }

  describe '#subtotal' do
    subject { promotion.subtotal(total) }

    let(:total) { 10 }

    context 'flat amount' do
      let(:promotion) { FactoryBot.build(:promotion, discount_type: Promotion::FLAT_AMOUNT, discount_amount: 1) }

      it { is_expected.to eq(-1) }
    end

    context 'percent' do
      let(:promotion) { FactoryBot.build(:promotion, discount_type: Promotion::PERCENT, discount_amount: 50) }

      it { is_expected.to eq(-5) }
    end
  end
end
