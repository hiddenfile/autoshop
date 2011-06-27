class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :price

      t.timestamps
    end
  end
end
