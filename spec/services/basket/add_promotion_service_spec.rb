# frozen_string_literal: true

require 'rails_helper'

describe Basket::AddPromotionService do
  describe '#run' do
    subject(:add_promotion) { described_class.new(basket, promotion).run }

    let(:basket) { FactoryBot.create(:basket) }

    context 'add known promotion' do
      let!(:promotion) { FactoryBot.create(:promotion) }

      it { expect { add_promotion }.to change { basket.reload.promotions.to_a }.from([]).to([promotion]) }
      it { is_expected.to eq(true) }
    end

    context 'add duplicate promotion' do
      before do
        basket.promotions << promotion
      end

      let(:promotion) { FactoryBot.create(:promotion) }

      it { expect { add_promotion }.not_to change { basket.reload.promotions.to_a }.from([promotion]) }
      it { is_expected.to eq(false) }
    end

    context 'add promotion which cannot be used in conjunction' do
      before do
        basket.promotions << basic_promotion
      end

      let(:basic_promotion) { FactoryBot.create(:promotion, conjunction: true) }
      let(:promotion) { FactoryBot.create(:promotion, conjunction: false) }

      it { expect { add_promotion }.not_to change { basket.reload.promotions.to_a }.from([basic_promotion]) }
      it { is_expected.to eq(false) }
    end

    context 'add known promotion with promotion which cannot be used in conjunction in basket' do
      before do
        basket.promotions << promotion_with_no_conjunction
      end

      let(:promotion_with_no_conjunction) { FactoryBot.create(:promotion, conjunction: false) }
      let(:promotion) { FactoryBot.create(:promotion, conjunction: true) }

      it do
        expect { add_promotion }
          .not_to change { basket.reload.promotions.to_a }
          .from([promotion_with_no_conjunction])
      end
      it { is_expected.to eq(false) }
    end
  end
end
