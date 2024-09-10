class RemoveShippingDaysIdFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :shipping_days_id, :integer
  end
end
