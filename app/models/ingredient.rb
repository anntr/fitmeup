class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :product
  accepts_nested_attributes_for :product

end