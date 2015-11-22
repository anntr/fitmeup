Prawn::Document.generate("fitmeup_przepisy.pdf") do
      text "Wygenerowano ze strony FitMeUp"
      text "#{Date.new}"
      move_down 100
      stroke_horizontal_rule
      pad_bottom(20) {
        font_size(25) { text @recipe.name }
        move_down 20
        default_leading 5
        text @recipe.instructions
        @recipe.ingredients.each do |ingredient|
          if ingredient.product
            text "#{ingredient.product.name}, #{ingredient.modifier} #{ingredient.measure.unit}"
          else
            text "#{ingredient.item}, #{ingredient.modifier} gram"
          end
        end
      }
    end