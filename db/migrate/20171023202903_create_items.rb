# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.belongs_to :product, foreign_key: true
      t.integer :quantity
      t.references :itemable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
