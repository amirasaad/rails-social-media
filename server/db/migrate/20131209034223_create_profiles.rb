# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[4.2]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :name
      t.date :birthday

      t.timestamps
    end
  end
end
