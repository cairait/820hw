class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    if @recipes.empty?
      render :json => {
          :error => "Oops, there's no recipes"
      }
    else
      render :json => {
          :response => "SUCCESS!",
          :data => @recipes
      }
    end
  end
  def create
    puts "this is the create method"
    @new_category_recipe = Recipe.new(recipe_params)
    if Category.exists?(@new_category_recipe.category_id)
      if @new_category_recipe.save
        render :json => {
            :response => "successfully created the category list recipe",
            :data => @new_category_recipe
        }
      else
        render :json => {
            :response => "oops something went wrong"
        }
      end
    else
      render :json => {
          :error => 'category list does not exist'
      }
    end
  end
  def show
    @single_recipe=Recipe.exists?(params[:id])
    if @single_recipe
      render :json => {
          :response => "successful",
          :data => Recipe.find(params[:id])
      }
    else
      render :json => {
          :error => "recipe not found"
      }
    end
  end
  def update
    if (@single_recipe_update=Recipe.find_by_id(params[:id])).present?
      @single_recipe_update.update(recipe_params)
      render :json => {
          :response => "successfully updated",
          :data => @single_recipe_update
      }
    else
      render :json => {
          :error => "cannot update the selected recipe"
      }
    end
  end
  def destroy
    if (@single_recipe_destroy=Recipe.find_by_id(params[:id])).present?
      @single_recipe_destroy.destroy
      render :json => {
          :response => "deletion successful",
          :data => @single_recipe_destroy
      }
    else
      render :json => {
          :error => "cannot delete the selected recipe"
      }
    end
  end
  private
  def recipe_params
    params.permit(:category_id, :name, :directions, :ingredients)
  end
end
