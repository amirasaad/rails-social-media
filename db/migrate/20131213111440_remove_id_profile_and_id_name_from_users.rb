class RemoveIdProfileAndIdNameFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :profile_name
    remove_column :users, :profile_id
  end
end
