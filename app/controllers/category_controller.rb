class CategoryController < ApplicationController
  def index
    @category_list = Category.all
    if @category_list.empty?
      render json: {
        'error': 'oops there is no data to show'
      }
    else
      render json: {
        response: 'successful',
          data: @category_list
      }

    end
  end

  def create
    @new_category = Category.new(category_params)
    if @new_category.save
      render json: {
        response: 'successfully created the category list',
        data: @new_category
      }
    else
      render json: {
        error: 'cannot save the data'
      }
    end
  end

  def update
    if(@single_category_update = Category.find_by_id(params[:id])).present?
      @single_category_update.update(category_params)
      render :json => {
          :response => 'successfully update the data',
          :data => @single_category_update
      }
    else
      render :json => {
          :response => 'cannot update the selected record'
      }
    end
  end

  def show
    @single_category = Category.exists?(params[:id])
    if @single_category
      render :json => {
          :response => 'successful',
          :data => Category.find(params[:id])
      }
    else
      render :json => {
          :response => 'record not found'
      }
    end
  end

  def destroy
    if (@category_delete = Category.find_by_id(params[:id])).present?
      @category_delete.destroy
      render :json => {
          :response => 'successfully delete the record'
      }
    else
      render :json => {
          :response => 'cannot delete the selected record'
      }
    end
  end


  private
  def category_params
    params.permit(:id, :title, :description, :created_by)
  end


  end
