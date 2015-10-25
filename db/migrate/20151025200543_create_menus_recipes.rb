class CreateMenusRecipes < ActiveRecord::Migration
  def change
    create_table :menus_recipes do |t|
      t.belongs_to :menu, index:true
      t.belongs_to :recipe, index: true
    end
  end
end
