class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show 
    @tag = Tag.find(params[:id]) 
    @recipes = @tag.recipes.sort_by{|recipe| recipe.average.to_i}.reverse

  end

  def new
    @tag = Tag.new
  end 

  def create 
    @tag = Tag.new(tag_params)

    if @tag.save
       redirect_to @tag
    else 
      render :new
    end 
  end 

  def edit
    @tag = Tag.find(params[:id])
  end 

  def update
    @tag = Tag.find(params[:id])

    if @tag.update(tag_params)
       redirect_to tag_path
    else
      render :edit
    end 
  end 

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to root_path
  end 

private
  def tag_params
    params.require(:tag).permit(:tagName, :recipe_id, :tags, :tag_id)
  end 
end
