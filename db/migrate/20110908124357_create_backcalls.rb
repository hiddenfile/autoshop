class CreateBackcalls < ActiveRecord::Migration
  def change
    create_table :backcalls do |t|
      t.text :content
      t.string :author
      t.integer :product_id

      t.timestamps
    end
  end
end
