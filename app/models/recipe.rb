class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :products, through: :ingredients
  belongs_to :user

  acts_as_votable
  acts_as_commentable

  accepts_nested_attributes_for :ingredients, :reject_if => proc { |attributes| attributes.any? {|k,v| v.blank?} }, :allow_destroy => true, :limit => 20
  accepts_nested_attributes_for :products


  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }, :default_url => ActionController::Base.helpers.asset_path('/images/empty_s.jpg')
  validates_attachment :image,:size => { :in => 0..1.megabytes }
  validates_attachment_content_type :image,
                                    :content_type => /^image\/(png|gif|jpeg)/

  validates :name, :instructions, :category, :ingredients, presence: true
  validates :name, length: { in: 3..100, wrong_length: "Tytuł musi mieć od 3 do 100 znaków"}
  validates :instructions, length: { maximum: 3000 }

  after_validation :uncheck_ingredients

  scope :any_category, -> (category){where(" ? = ANY(category)", category)}

  def image_attached?
    self.image.file?
  end

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



