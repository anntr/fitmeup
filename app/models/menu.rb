class Menu < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  belongs_to :user

  scope :saved_menus, lambda { |curr_user|
                          where(:user => curr_user, :saved => true).order(created_at: :desc)}


  def saved?
    saved
  end

  def to_pdf
    menu = self
    Prawn::Document.new do
      font_families.update("Arial" => {
                               :normal => "public/assets/fonts/arial.ttf"})
      font "Arial"
      text "Wygenerowano ze strony FitMeUp"
      move_down 40
      stroke_horizontal_rule
      menu.recipes.each do |recipe|
        move_down 20
        pad_bottom(20) {
          font_size(25) { text recipe.name }
          move_down 20
          default_leading 5
          recipe.ingredients.each do |ingredient|
            if ingredient.product
              text "#{ingredient.product.name_t}, #{ingredient.modifier} #{ingredient.measure.unit_t}"
            else
              text "#{ingredient.item}, #{ingredient.modifier} gram"
            end
          end
          move_down 20
          text recipe.instructions
          move_down 20
          stroke_horizontal_rule
        }
      end
    end.render
  end

  def shopping_list_pdf
    menu = self
    Prawn::Document.new do
      font_families.update("Arial" => {
                               :normal => "public/assets/fonts/arial.ttf"})
      font "Arial"
      text "Wygenerowano ze strony FitMeUp"
      move_down 40
      stroke_horizontal_rule
      menu.recipes.each do |recipe|
        move_down 20
        pad_bottom(20) {
          font_size(25) { text recipe.name }
          move_down 20
          default_leading 5
          recipe.ingredients.each do |ingredient|
            if ingredient.product
              text "#{ingredient.product.name_t}, #{ingredient.modifier} #{ingredient.measure.unit_t}"
            else
              text "#{ingredient.item}, #{ingredient.modifier} gram"
            end
          end
          move_down 20
          text recipe.instructions
          move_down 20
          stroke_horizontal_rule
        }
      end
    end.render
  end
=begin

  def shopping_list
    list = {}
    self.recipes.each do |recipe|
      recipe.ingredients.each do |ingredient|
        if ingredient.product
          list["#{ingredient.product.name_t}"] = {:unit => ingredient.measure.unit_t, :quantity => ingredient.modifier}
        else
          list[""]
        end

      end
    end
  end
=end
end
