# frozen_string_literal: true

module Baskets
  class ItemsController < ApplicationController
    after_action :update_basket_manager

    def create
      item = current_basket.items.find_or_initialize_by(product_id: create_item_params[:product_id])
      item.itemable = current_basket
      item.quantity ||= 0
      item.quantity += create_item_params[:quantity].to_i
      item.save
      redirect_to root_path
    end

    def update
      item = current_basket.items.find(params[:id])
      Item::UpdateService.new(item, update_item_params).run
      redirect_to root_path
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end

    private

    def create_item_params
      params.require(:item).permit(:product_id, :quantity)
    end

    def update_item_params
      params.require(:item).permit(:quantity)
    end
  end
end
