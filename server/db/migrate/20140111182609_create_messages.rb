# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[4.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :sender_id
      t.integer :reciver_id

      t.timestamps
    end
  end
end
