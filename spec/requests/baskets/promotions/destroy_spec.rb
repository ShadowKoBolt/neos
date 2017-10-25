# frozen_string_literal: true

require 'rails_helper'

describe 'Baskets / Promotions', type: :request do
  describe 'DELETE basket/promotion/:id' do
    subject(:make_request) do
      delete basket_promotion_path(id: promotion.id)
      response
    end

    let(:promotion) { FactoryBot.create(:promotion) }
    let(:basket) { FactoryBot.create(:basket) }

    before do
      allow(BasketManager).to receive(:new).and_return(instance_double('BasketManager', find: basket))
    end

    context 'promotion in basket' do
      before do
        basket.promotions << promotion
      end

      it { is_expected.to redirect_to root_path }
      it { expect { make_request }.to change { basket.reload.promotions.to_a }.from([promotion]).to([]) }
    end

    context 'promotion not basket' do
      it { is_expected.to redirect_to root_path }
    end
  end
end
