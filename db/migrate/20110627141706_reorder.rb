class Reorder < ActiveRecord::Migration
  def self.up
    remove_column :companies, :product_id
    remove_column :groups, :product_id

    add_column :products, :company_id, :integer
    add_column :products, :group_id, :integer
  end

  def self.down
    add_column :companies, :product_id, :integer
    add_column :groups, :product_id, :integer

    remove_column :products, :company_id
    remove_column :products, :group_id
  end
end
