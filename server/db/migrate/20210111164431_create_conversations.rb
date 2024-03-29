# frozen_string_literal: true

class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps
    end
    add_index :conversations, :sender_id
    add_index :conversations, :receiver_id
    add_index :conversations, %i[sender_id receiver_id], unique: true
  end
end
