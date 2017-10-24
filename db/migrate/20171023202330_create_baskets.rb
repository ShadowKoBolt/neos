# frozen_string_literal: true

class CreateBaskets < ActiveRecord::Migration[5.1]
  def change
    create_table :baskets do |t|
      t.string :email
      t.text :address

      t.timestamps
    end
  end
end
