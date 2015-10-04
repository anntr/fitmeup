class Ingredient < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :calories, :numericality => {:greater_than => 0}
end
