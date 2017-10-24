# frozen_string_literal: true

require 'rails_helper'

describe BasketManager do
  describe '#find' do
    subject { described_class.new(session: session).find }

    context 'no session' do
      let(:session) { {} }

      it { is_expected.to be_a(Basket) }
      it { is_expected.not_to be_persisted }
    end

    context 'invalid ID in session' do
      let(:session) { { basket_id: 1 } }

      it { is_expected.to be_a(Basket) }
      it { is_expected.not_to be_persisted }
    end

    context 'valid ID in session' do
      let(:basket) { Basket.create }
      let(:session) { { basket_id: basket.id } }

      it { is_expected.to eq(basket) }
    end
  end
end
