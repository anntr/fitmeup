class PrivateMenuAndRecipe < ActiveRecord::Migration
  def change
    add_reference :recipes, :user, index: true
    add_reference :menus, :user, index: true
  end
end
