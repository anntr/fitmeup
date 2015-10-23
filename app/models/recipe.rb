class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :products, through: :ingredients
  accepts_nested_attributes_for :ingredients
  accepts_nested_attributes_for :products

  validates :name, :instructions, :category, presence: true

  scope :any_category, -> (category){ where(" ? = ANY(category)", category)}


  def self.sort_for_algorithm
    all_recipes = Recipe.all
    sorted_recipes = []
    (1..5).each do |index|
      sorted_recipes.push(all_recipes.select{|item| item.category.include?(index.to_s)})
    end
    sorted_recipes
  end

end



