# frozen_string_literal: true

class RenamePasswordToHashedPassword < ActiveRecord::Migration[4.2]
  def change
    rename_column :users, :password, :hashed_password
  end
end
