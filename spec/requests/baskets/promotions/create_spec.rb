# frozen_string_literal: true

require 'rails_helper'

describe 'Baskets / Promotions', type: :request do
  describe 'POST basket/promotions' do
    subject(:make_request) do
      post basket_promotions_path, params: params
      response
    end

    before do
      allow(BasketManager).to receive(:new).and_return(instance_double('BasketManager', find: basket))
    end

    let(:basket) { FactoryBot.create(:basket) }
    let(:params) { { promotion: { code: 'code' } } }

    context 'unknown promotion code' do
      it { is_expected.to redirect_to root_path }
      it do
        make_request
        expect(flash[:notice]).to eq(I18n.t('baskets.promotions.create.code_not_found'))
      end
    end

    context 'failed to add promotion code' do
      before do
        FactoryBot.create(:promotion, code: 'code')
        allow(Basket::AddPromotionService).to receive(:new)
          .and_return(instance_double('Basket::AddPromotionService', run: false))
      end

      it { is_expected.to redirect_to root_path }
      it do
        make_request
        expect(flash[:notice]).to eq(I18n.t('baskets.promotions.create.unable_to_add_code'))
      end
    end

    context 'added promotion code' do
      before do
        FactoryBot.create(:promotion, code: 'code')
        allow(Basket::AddPromotionService).to receive(:new)
          .and_return(instance_double('Basket::AddPromotionService', run: true))
      end
      it { is_expected.to redirect_to root_path }
      it do
        make_request
        expect(flash[:notice]).to eq(I18n.t('baskets.promotions.create.code_added'))
      end
    end
  end
end
