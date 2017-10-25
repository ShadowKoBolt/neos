# frozen_string_literal: true

require 'rails_helper'

describe 'Baskets', type: :request do
  describe 'GET /' do
    subject do
      get root_path
      response
    end

    it { is_expected.to have_http_status(:ok) }
  end
end
