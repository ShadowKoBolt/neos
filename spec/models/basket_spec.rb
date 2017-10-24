# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Basket, type: :model do
  it { is_expected.to have_many(:items) }
end
