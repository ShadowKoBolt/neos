# frozen_string_literal: true

require 'rails_helper'

describe Basket::ConvertToOrder do
  describe '#run' do
    subject(:run) { described_class.new(basket).run }

    let(:basket) { FactoryBot.create(:basket, basket_attributes) }
    let(:basket_attributes) { { email: 'a@b.com', line_1: '1' } }
    let(:product1) { FactoryBot.create(:product, price: 10) }
    let(:product2) { FactoryBot.create(:product, price: 20) }
    let(:promotion) { FactoryBot.create(:promotion, discount_type: Promotion::FLAT_AMOUNT, discount_amount: 1) }

    before do
      basket.items << FactoryBot.create(:item, quantity: 3, itemable: product1)
      basket.items << FactoryBot.create(:item, quantity: 1, itemable: product2)
      FactoryBot.create(:basket_promotion, basket: basket, promotion: promotion)
    end

    it { expect(run[:success]).to eq(true) }
    it { expect(run[:order]).to be_a(Order) }
    it { expect { run }.to change { Basket.count }.from(1).to(0) }
    it { expect { run }.to change { Order.where(email: 'a@b.com').count }.from(0).to(1) }
    it { expect { run }.to change { OrderItem.count }.from(0).to(3) }
  end
end
