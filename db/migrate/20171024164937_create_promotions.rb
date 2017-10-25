# frozen_string_literal: true

class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.string :name
      t.string :code
      t.string :discount_type
      t.integer :discount_amount
      t.boolean :conjunction, default: false

      t.timestamps
    end
  end
end
