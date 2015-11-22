class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :product
  belongs_to :measure

  validates :modifier, numericality: { greater_than: 0 }

end