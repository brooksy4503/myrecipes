class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update]
  
  def index
    @recipes = Recipe.all
  end
  
  def show
    set_recipe
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first #change this later
    if @recipe.save
      flash[:success] = "Recipe was created successfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end
  
  
  def edit
    
    set_recipe
    
  end
  
  def update
    set_recipe
    if @recipe.update(recipe_params)
      flash[:success] = "recipes was updated successfully!"
      redirect_to recipe_path(@recipe)
    else
     render 'edit'
    end
  end
    
def destroy
  Recipe.find(params[:id]).destroy
  flash[:success] = "recipe deleted successfully"
  redirect_to recipes_path
end
  
  private
  
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
  
  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
  
end
  
