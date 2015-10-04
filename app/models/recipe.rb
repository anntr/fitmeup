class Recipe < ActiveRecord::Base
  has_many :ingredients
  validates :name, :category, presence: true


  def self.sort_for_algorithm
    all_recipes = Recipe.all
    sorted_recipes = []
    (1..5).each do |index|
      sorted_recipes.push(all_recipes.select{|item| item.category == index})
    end
    sorted_recipes
  end

end



