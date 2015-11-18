require './lib/IngredientFacade'

class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  autocomplete :product, :name, :full => true, :limit => 20

  # GET /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @recipe = Recipe.find(params[:id])
    @comment = @recipe.comments.new
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  def upvote
    @recipe = Recipe.find(params[:id])
    @recipe.liked_by current_user
    redirect_to(@recipe, notice: "Głos został oddany")
  end

  def downvote
    @recipe = Recipe.find(params[:id])
    @recipe.downvote_from current_user
    redirect_to(@recipe, notice: "Głos został oddany")
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    params = recipe_params
    @recipe = Recipe.new(params.except(:ingredients_attributes))
    add_ingredients(params[:ingredients_attributes])

    @recipe.calculate_calories

    if params[:user_id] == "1"
      @recipe.user = current_user
    end

    respond_to do |format|
      if @recipe.save
        flash.now[:success] = 'Przepis został stworzony pomyślnie!'
        format.html { render :edit }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    params = recipe_params
    @recipe.update(params.except(:ingredients_attributes))
    add_ingredients(params[:ingredients_attributes])
    @recipe.calculate_calories
    if params[:user_id] == "1"
      @recipe.user = current_user
    end

    respond_to do |format|
      if @recipe.save
        flash.now[:success] = 'Przepis został zakutalizowany!'
        format.html { render :edit}
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def rate_fitness
    calories_fitness
  end

  private

    def add_ingredients params
      ingredients = []
      params.each do |key, value|
        ingredients << add_ingredient(value)
      end
      @recipe.ingredients = ingredients
    end

    def add_ingredient params
      ingredient = Ingredient.find_by_id(params["id"]) || Ingredient.new(:modifier => params["modifier"])
      if ingredient.persisted? && params["_destroy"] != "false"
          ingredient.mark_for_destruction
      else
        product = Product.where(:name => params["product"]["name"]).first
        if product
          ingredient.measure = product.measures.where(:unit => params["measure"]).first
          ingredient.product = product
        else
          ingredient.item = params["product"]["name"]
        end
      end
      ingredient
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:name, :instructions, :user_id, :image, :servings, :calories, :category => [],
                                     :menu_ids => [], :ingredients_attributes => [:id, :item, :measure, :modifier,
                                                                                  :_destroy, :product => :name])
    end
end
