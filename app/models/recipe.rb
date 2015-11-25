class Recipe < ActiveRecord::Base
  has_many :ingredients, :dependent => :destroy
  has_many :products, through: :ingredients
  belongs_to :user

  acts_as_votable
  acts_as_commentable

  accepts_nested_attributes_for :ingredients, :reject_if => proc { |attributes| attributes.any? {|k,v| v.blank?} }, :allow_destroy => true, :limit => 20
  accepts_nested_attributes_for :products

  has_attachment :image, accept: [:jpg, :png, :gif]

  validates :name, :instructions, :category, :ingredients, presence: true
  validates :name, length: { in: 3..100, wrong_length: "Tytuł musi mieć od 3 do 100 znaków"}
  validates :instructions, length: { maximum: 3000 }

  after_validation :uncheck_ingredients
  before_save :calculate_calories

  scope :any_category, -> (category){where(" ? = ANY(category)", category).where(:private => false)}
  scope :user_recipes, lambda { |curr_user|
                       where(:user => curr_user)
                     }

  def calculate_calories
    total_value = 0
    ingredients.each do |ingredient|
      total_value += ( ingredient.measure.calories * ingredient.modifier ) if ingredient.product
    end
    self.calories = total_value.round / servings
  end


  def self.sort_for_algorithm
    all_recipes = Recipe.where("calories > 0")
    sorted_recipes = []
    (1..5).each do |index|
      sorted_recipes.push(all_recipes.select{|item| item.category.include?(index.to_s)})
    end
    sorted_recipes
  end

  def uncheck_ingredients
    if errors.any?
      ingredients.each do |ingredient|
        ingredient.reload if ingredient.marked_for_destruction?
      end
    end
  end


end



