class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :product
  belongs_to :measure
end