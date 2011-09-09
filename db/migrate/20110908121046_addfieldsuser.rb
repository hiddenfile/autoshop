class Addfieldsuser < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :user_phone, :string
  end

  def down
    remove_column :users, :first_name, :string
    remove_column :users, :middle_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :user_phone, :string
  end
end
