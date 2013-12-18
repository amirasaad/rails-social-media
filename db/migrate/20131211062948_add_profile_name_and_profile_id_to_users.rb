class AddProfileNameAndProfileIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :profile_name, :string,:default => "user"
    add_column :users, :profile_id, :string,:null => false,:unique => true,:default => "profile_id"
  end
end
