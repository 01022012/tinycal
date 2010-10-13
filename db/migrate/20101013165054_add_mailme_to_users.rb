class AddMailmeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :mail_me, :boolean,:default=>false,:null=>false
  end

  def self.down
    remove_column :users, :mail_me
  end
end
