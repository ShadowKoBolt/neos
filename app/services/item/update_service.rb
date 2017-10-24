# frozen_string_literal: true

class Item::UpdateService
  def initialize(item, params)
    @item = item
    @params = params
  end

  def run
    return @item.destroy if @params.key?(:quantity) && !@params[:quantity].to_i.positive?
    @item.update(@params)
  end
end
