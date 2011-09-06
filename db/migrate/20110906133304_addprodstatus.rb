class Addprodstatus < ActiveRecord::Migration
  def up
    add_column :products, :status, :string, :default => 'enable'
  end

  def down
    remove_column :products, :status
  end
end
