class RenameIngredientTableToProductTable < ActiveRecord::Migration
  def change
    #drop_table :products
    rename_table :ingredients, :products
  end
end
