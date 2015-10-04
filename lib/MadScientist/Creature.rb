require  File.expand_path('../Scientist.rb', __FILE__)

class Creature
  attr_accessor :fitness, :chromosome_set
  def initialize chromosome_set
    @chromosome_set = chromosome_set
    @fitness = -100
  end

  def select?
    p = rand.round(2)
    p > 0.5
  end
end