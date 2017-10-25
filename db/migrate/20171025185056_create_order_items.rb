# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.string :name
      t.integer :quantity
      t.integer :subtotal
      t.belongs_to :order, foreign_key: true
      t.references :order_itemable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
