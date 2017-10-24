# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_basket
    @current_basket ||= BasketManager.new(session: session).find
  end

  def update_basket_manager
    return if session[:basket_id] == current_basket.id
    session[:basket_id] = current_basket.id
  end
end
