class AddProteinsAndCarbsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :carbs, :float
    add_column :recipes, :proteins, :float
    add_column :recipes, :servings, :integer
  end
end
