class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :products, through: :ingredients
  belongs_to :user

  accepts_nested_attributes_for :ingredients, :reject_if => proc { |attributes| attributes.any? {|k,v| v.blank?} }, :allow_destroy => true, :limit => 20
  accepts_nested_attributes_for :products

  validates :name, :instructions, :category, :ingredients, presence: true

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



