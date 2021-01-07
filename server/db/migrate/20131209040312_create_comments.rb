# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[4.2]
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.string :user_id
      t.text :body

      t.timestamps
    end
  end
end
