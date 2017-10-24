# frozen_string_literal: true

require 'rails_helper'

describe Item::UpdateService do
  describe '#run' do
    subject(:run) { described_class.new(item, params).run }

    let!(:item) { FactoryBot.create(:item, quantity: 1) }

    context 'increase quantity' do
      let(:params) { { quantity: 2 } }

      it { expect { run }.to change { item.reload.quantity }.from(1).to(2) }
    end

    context 'set quantity to zero' do
      let(:params) { { quantity: 0 } }

      it { expect { run }.to change { Item.count }.from(1).to(0) }
    end
  end
end
