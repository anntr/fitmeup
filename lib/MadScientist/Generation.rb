class Generation

  def initialize population
    @population = population
  end

  def sort_population population = @population
    population.sort_by!{ |creature| creature.fitness}.reverse!
  end

  def tournmanet_selection sample_size=100
    parents = []
    sample = sort_population(@population.sample(sample_size))
    sample.each do |creature|
      parents << creature if creature.select?
      return parents if parents.size == 2
    end
  end

  def crossover
    parents = tournmanet_selection
    children = mix_chromosmes parents
    return Creature.new(children.first), Creature.new(children.last)
  end

  def generate_new_population population = @population
    size = population.size/2
    new_population = []
    (1..size).each do
      children = crossover
      new_population << children.first
      new_population << children.last
    end
    new_population
  end

  private

  def mix_chromosmes parents
    [parents.first.chromosome_set.first(2) + parents.last.chromosome_set.last(3),
     parents.last.chromosome_set.first(2) +  parents.first.chromosome_set.last(3)]
  end
end