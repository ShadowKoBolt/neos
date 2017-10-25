# frozen_string_literal: true

module Baskets
  class PromotionsController < ApplicationController
    def create
      promotion = Promotion.find_by_code(create_params[:code])
      return redirect_to root_path, notice: t('.code_not_found') unless promotion
      notice = if Basket::AddPromotionService.new(current_basket, promotion).run
                 t('.code_added')
               else
                 t('.unable_to_add_code')
               end
      redirect_to root_path, notice: notice
    end

    def destroy
      promotion = Promotion.find(params[:id])
      current_basket.promotions = current_basket.promotions.reject do |existing_promotion|
        existing_promotion == promotion
      end
      current_basket.save
      redirect_to root_path
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end

    private

    def create_params
      params.require(:promotion).permit(:code)
    end
  end
end
