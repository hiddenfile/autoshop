class Reorder < ActiveRecord::Migration
  def up
    remove_column :companies, :product_id, :integer
    remove_column :groups, :product_id, :integer

    add_column :products, :company_id, :integer
    add_column :products, :group_id, :integer
  end

  def down
    add_column :companies, :product_id, :integer
    add_column :groups, :product_id, :integer

    remove_column :products, :company_id, :integer
    remove_column :products, :group_id, :integer
  end
end
