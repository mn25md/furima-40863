class CreateShippingCosts < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_costs do |t|
      t.string :name, null: false 
      t.integer :cost

      t.timestamps
    end
  end
end
