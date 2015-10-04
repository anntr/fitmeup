require  File.expand_path('../Genotype.rb', __FILE__)

class Meal
  attr_accessor :calories, :carbs, :lipids, :proteins, :name, :type
  def initialize(options = {})
    @name = options[:name]
    @calories = options[:calories]
    @carbs = options[:carbs]
    @lipids = options[:lipids]
    @proteins = options[:proteins]
    @type = options[:type]
  end

  MEAL_DATABASE = (1..10000).map { Meal.new(
      :name => ('a'..'z').to_a.shuffle[0, 4].join,
      :calories => 100+rand(5000),
      :carbs => 190+rand(2000),
      :lipids => 30+rand(600),
      :proteins => 40+rand(1000),
      :type => rand(5)+1)}

  def self.generate_database_for_alg
    sorted_array = []
    database = MEAL_DATABASE
    (1..5).each do |index|
      sorted_array.push( database.select{|item| item.type == index} )
    end
    sorted_array
  end

  def self.generate_test_menu
    MEAL_DATABASE.sample(5)
  end

#  Scientist.class_eval do
    def rate_fitness
      calories_fitness + nutrient_fitness
    end


end