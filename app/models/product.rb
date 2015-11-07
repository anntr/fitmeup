class Product < ActiveRecord::Base
  has_many :ingredients
  has_many :recipes, through: :ingredients
  has_many :measures
  validates :name, uniqueness:  true

end