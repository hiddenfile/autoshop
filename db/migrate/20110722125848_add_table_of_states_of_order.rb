class AddTableOfStatesOfOrder < ActiveRecord::Migration
  def up
    create_table :order_state_types do |t|
      t.string :state

      t.timestamps
    end
  end

  def down
    drop_table :order_state_types
  end
end
