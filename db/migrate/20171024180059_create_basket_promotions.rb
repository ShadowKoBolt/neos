# frozen_string_literal: true

class CreateBasketPromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :basket_promotions do |t|
      t.belongs_to :basket
      t.belongs_to :promotion
    end
  end
end
