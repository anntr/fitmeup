class AddNutreintToProduct < ActiveRecord::Migration
  def change
    add_column :products, :carbs, :float
    add_column :products, :lipids, :float
    add_column :products, :proteins, :float
  end
end
