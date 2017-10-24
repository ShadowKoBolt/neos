# frozen_string_literal: true

class BasketManager
  def initialize(session:)
    @session = session
  end

  def find
    Basket.where(id: @session[:basket_id]).first || Basket.new
  end
end
