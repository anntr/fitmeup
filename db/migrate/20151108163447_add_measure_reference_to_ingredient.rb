class AddMeasureReferenceToIngredient < ActiveRecord::Migration
  def change
    add_reference :ingredients, :measure, index: true
  end
end
