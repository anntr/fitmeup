class ChangeRecipesCategories < ActiveRecord::Migration
  def change
    change_column :recipes, :category, :string, array: true, default: '{}'
  end
end
