class IngredientsController < ApplicationController

  private

  def ingredient_params
    params.require(:ingredient).permit(:measure, :item, :modifier, :products => :name)
  end


end
