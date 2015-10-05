require  File.expand_path('../Scientist.rb', __FILE__)

class Dietician < Scientist
  def initialize total_cal = 2000
    @diet = total_cal
  end

  def rate_chromosome_fitness(chromosome)
    calc_fitness "calories",nil, chromosome
  end

  def rate_creature_fitness(creature)
    fitness = 0
    total_cal = 0
    creature.chromosome_set.each do |meal|
      total_cal += meal.calories
      fitness += rate_chromosome_fitness meal
    end
    creature.fitness = fitness + calc_fitness("diet", total_cal)
  end

  def get_reference type, chromosome = nil
    if type == "calories"
      test = chromosome.send(:category)
      case test
        when 1,5
          @diet*0.2
        when 2,4
          @diet*0.1
        when 3
          @diet*0.4
        else
          200
      end
    elsif type == "diet"
      1500
    else
      case type
        when "carbs"
          @diet*0.6
        when "lipids"
          @diet*0.25
        when "proteins"
          @diet*0.15
      end
    end
  end

  def calc_fitness type, total_value = nil, chromosome = nil
    p = rand.round(2)
    ref_value = get_reference(type, chromosome)
    total_value ||= chromosome.send(type)
    if total_value.between?(ref_value*(1-0.5*p), ref_value*(1+0.5*p))
      return 4 if type == "calories"
      return 3
    elsif total_value.between?(ref_value*(1-p), ref_value*(1-0.5*p)) || total_value.between?(ref_value*(1+p*0.5), ref_value*(1+p))
      return 2 if type == "calories"
      return 1
    elsif total_value < ref_value*ref_value*0.5 || total_value > ref_value
      return -3
    end
  end

end
