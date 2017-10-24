# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Baskets / Items', type: :request do
  describe 'PATCH basket/item/:id' do
    subject(:make_request) do
      patch basket_item_path(id: item.id), params: params
      response
    end

    let!(:item) { FactoryBot.create(:item, quantity: 2, itemable: basket) }
    let(:params) { { item: { quantity: 1 } } }
    let(:basket) { Basket.create }

    context 'set quantity to 1' do
      before do
        allow(BasketManager).to receive(:new) { instance_double('BasketManager', find: basket) }
      end

      it { expect { make_request }.to change { item.reload.quantity }.from(2).to(1) }
      it { is_expected.to redirect_to(root_path) }
    end

    context 'set quantity to 0' do
      before do
        allow(BasketManager).to receive(:new) { instance_double('BasketManager', find: basket) }
      end

      let(:params) { { item: { quantity: 0 } } }
      it { expect { make_request }.to change { Item.count }.from(1).to(0) }
      it { is_expected.to redirect_to(root_path) }
    end

    context 'update another baskets item' do
      it { expect { make_request }.to_not change { item.reload.quantity } }
      it { is_expected.to redirect_to(root_path) }
    end
  end
end
