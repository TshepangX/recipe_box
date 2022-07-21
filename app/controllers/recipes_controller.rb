class RecipesController < ApplicationController
  include AverageCalculator
  def index
    if params[:search]
      
      @recipes = Recipe.joins(:ingredients).where(ingredients: {name: params[:search] })
    else
      @recipes = Recipe.all
      @recipe = @recipes.sort_by{|recipe| recipe.average.to_i}.reverse
  end
end

  def show
    @recipe = Recipe.find(params[:id])
    @score = average(@recipe)
    @tags = @recipe.tags
    @rating = @recipe.ratings
    @ingredients = @recipe.ingredients
  end

  def new 
    @recipe = Recipe.new
    @ingredients = Ingredient.pluck(:name)
    @tags = Tag.pluck(:tagName)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    params[:recipe][:ingredients].each do |name|
      ingredient = Ingredient.find_by(name: name)
    @recipe.ingredients << ingredient
    end
    params[:recipe][:tags].each do |tag|
      tag = Tag.find_by(tagName: tag)
      @recipe.tags << tag
    end
      
    if @recipe.save 
      redirect_to @recipe
    else 
      render :new
    end 
  end 

  def edit
    @recipe = Recipe.find(params[:id])
    @ingredients = Ingredient.pluck(:name)
    @tags = Tag.pluck(:tagName)
  end

  def update

    @recipe = Recipe.find(params[:id])
    @recipe.ingredients.destroy_all
    @recipe.tags.destroy_all
    params[:recipe][:ingredients].each do |name|
      ingredient = Ingredient.find_by(name: name)
    @recipe.ingredients << ingredient
    end
    params[:recipe][:tags].each do |category|
      tag = Tag.find_by(tagName: category)
      @recipe.tags << tag
    end
 
    if @recipe.update(recipe_params)
      redirect_to recipe_path
    else
      render :edit
    end 
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to root_path
  end
  

private
  def recipe_params
    params.require(:recipe).permit(:title, :instruction, :recipe_id, :ingredients, :ingredient_id, :tag_ids, :tags) 
  end
end

