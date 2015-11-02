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
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end



  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    puts "___RECIPES CONTROLLER CREATE"
    params = recipe_params
    @recipe = Recipe.new(params.except(:ingredients_attributes))
    add_ingredients(params[:ingredients_attributes])
    puts "STWORZO NY RECIPE"
    puts @recipe.inspect
    if recipe_params[:user_id] == "1"
      @recipe.user = current_user
    end

    puts "PRZYPISANY USEROWI"
    puts @recipe.inspect
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
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
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
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
        product = Product.where(:name => value["product"]["name"]).first
        ingredient = Ingredient.new(:measure => value["measure"], :modifier => value["modifier"], :product => product)
        ingredients << ingredient
      end
      @recipe.ingredients = ingredients
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:name, :instructions, :user_id, :image, :category => [], :menu_ids => [], :ingredients_attributes => [:id, :item, :measure, :modifier, :_destroy, :product => :name])
    end
end
