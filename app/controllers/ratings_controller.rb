class RatingsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @rating = @recipe.ratings.create(rating_params)
    redirect_to recipe_path(@recipe)
 end
 
 def destroy
   @recipe = Recipe.find(params[:recipe_id])
   @rating = @recipe.ratings.find(params[:id])
   @rating.destroy
   redirect_to recipe_path(@recipe)
 end
 
 private
   def rating_params
     params.permit(:score)
   end
 end
