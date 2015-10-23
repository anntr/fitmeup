class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.integer :measure
      t.string :modifier
      t.string :item
      t.integer :product_id
      t.integer :recipe_id
    end
    add_index :ingredients, :product_id
    add_index :ingredients, :recipe_id
  end
end
