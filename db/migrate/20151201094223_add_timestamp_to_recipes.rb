class AddTimestampToRecipes < ActiveRecord::Migration
  def change
    add_timestamps(:recipes)
  end
end
