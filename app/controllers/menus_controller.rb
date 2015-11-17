require 'MadScientist/Dietician'
require 'MadScientist/Laboratory'

class MenusController < ApplicationController
  skip_before_action :authorize, only: :generate
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.all
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
  end

  def save
    @menu = params[:menu]
    @menu.save!
    render "show"
  end

  def generate
    calories = params[:calories]
    scientist = Dietician.new(calories.to_i)
    database = Recipe.sort_for_algorithm
    database.each do |category|
      if category.blank?
        redirect_to root_path, notice: "za mała baza by wygenerować menu" and return
      end
    end
      laboratory = Laboratory.new scientist, database, 500
      res = laboratory.produce_result
      parse_results(res.first.chromosome_set)

    render "show"
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)

    respond_to do |format|
      if @menu.save
        format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
        format.json { render :show, status: :created, location: @menu }
      else
        format.html { render :new }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render :edit }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to menus_url, notice: 'Menu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def parse_results results
      @menu = Menu.new
      @menu.recipes<<results
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      #params[:menu]
      params.require(:menu).permit(:recipe_id => [])
    end
end
