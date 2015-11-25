require 'faker'
files = Dir.glob("./zdjecia/PRZEPISY/*")
(1..400).each do |i|
  begin
    recipe = Recipe.new
    recipe.name = Faker::Hipster.words(rand(1..10), true, true).join(" ")
    recipe.instructions = Faker::Hipster.paragraphs(rand(1..4), true).join(" ")
    arr = []
    max = rand(2..6)
    (1...max).each do
      arr << rand(1...6).to_s
    end
    puts i
    recipe.category = arr.uniq
    recipe.servings = rand(1...7)
    img = Cloudinary::Uploader.upload(files.sample).except('signature', 'created_at', 'bytes', 'type',
                                                           'etag', 'url', 'secure_url')
    if img
      recipe.image = img
    end

    recipe.private = false

    products = Product.limit(rand(1..6)).order("RANDOM()")
    products.each do |prod|
      if prod.name_t
        ingredient = Ingredient.new
        ingredient.product = prod
        ingredient.measure = prod.measures.limit(1).order("RANDOM()").first
        if ingredient.measure.unit == "gram"
          ingredient.modifier = rand(1...50)
        else
          ingredient.modifier = rand(1..5)
        end
        recipe.ingredients << ingredient
      end
    end

    recipe.save!


    if recipe.save
      puts "ok"
    else
      puts "wrong"
    end
  rescue StandardError => e
    puts "ojojoooooj"
  end


end