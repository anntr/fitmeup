class FixIngredientsColumns < ActiveRecord::Migration
  def change
    remove_column :ingredients, :measure, :integer
    remove_column :ingredients, :modifier, :string
    add_column :ingredients, :modifier, :integer
  end
end
