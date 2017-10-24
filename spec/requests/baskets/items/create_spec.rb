# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Baskets / Items', type: :request do
  describe 'POST basket/item' do
    subject(:make_request) do
      post basket_items_path, params: params
      response
    end

    let(:product) { Product.create(name: 'product', price: 1) }

    context 'valid params with no existing basket' do
      let(:params) { { item: { product_id: product.id, quantity: 1 } } }

      it { expect { make_request }.to change { Basket.count }.from(0).to(1) }
      it { expect { make_request }.to change { Item.count }.from(0).to(1) }
      it { is_expected.to redirect_to root_path }
    end

    context 'valid params with existing basket' do
      let(:params) { { item: { product_id: product.id, quantity: 1 } } }
      let!(:basket) { Basket.create }

      before do
        allow(BasketManager).to receive(:new) { instance_double('BasketManager', find: basket) }
      end

      it { expect { make_request }.not_to change { Basket.count }.from(1) }
      it { expect { make_request }.to change { basket.items.count }.from(0).to(1) }
      it { is_expected.to redirect_to root_path }
    end

    context 'valid params with some of item already in basket' do
      let(:params) { { item: { product_id: product.id, quantity: 1 } } }
      let(:basket) { Basket.create }
      let!(:item) { Item.create(itemable: basket, product: product, quantity: 1) }

      before do
        allow(BasketManager).to receive(:new) { instance_double('BasketManager', find: basket) }
      end

      it { expect { make_request }.not_to change { Basket.count }.from(1) }
      it { expect { make_request }.not_to change { basket.items.count }.from(1) }
      it { expect { make_request }.to change { item.reload.quantity }.from(1).to(2) }
      it { is_expected.to redirect_to root_path }
    end

    context 'invalid params with no existing basket' do
      let(:params) { { item: { quantity: 0 } } }

      it { expect { make_request }.not_to change { Basket.count }.from(0) }
      it { expect { make_request }.not_to change { Item.count }.from(0) }
      it { is_expected.to redirect_to root_path }
    end

    context 'invalid params with existing basket' do
      let(:params) { { item: { quantity: 0 } } }

      before do
        basket = Basket.create
        allow(BasketManager).to receive(:new) { instance_double('BasketManager', find: basket) }
      end

      it { expect { make_request }.not_to change { Basket.count }.from(1) }
      it { expect { make_request }.not_to change { Item.count }.from(0) }
      it { is_expected.to redirect_to root_path }
    end
  end
end
