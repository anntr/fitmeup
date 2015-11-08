class FixCalories < ActiveRecord::Migration
  def change
    remove_column :measures, :calories, :integer
    add_column :measures, :calories, :float
    remove_column :products, :calories, :integer
    add_column :products, :calories, :float
  end
end
