class AddIsSoldToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :is_sold, :boolean, default: false
  end
end
