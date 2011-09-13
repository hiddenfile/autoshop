class AddCheckColumnToCallBack < ActiveRecord::Migration
  def change
    add_column :backcalls, :checked, :boolean, :default => false
  end
end
