class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show new update destroy]

  def index
    @categories = Category.where(author_id: current_user.id).order(created_at: :desc)
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.includes(:entities).find(params[:id])
    @entities = @category.entities.order(created_at: :desc)
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    @category.author = current_user
    if @category.save
      redirect_to categories_path
      flash[:notice] = 'Category was created successfully'
    else
      flash[:notice] = 'couldnt created the category'
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to category_url(@category)
      flash[:notice] = 'category was updated successfully'
    else
      flash[:notice] = 'created couldnt updated'
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
    flash[:notice] = 'category has been destroy succesfully'
  end

  private

  def set_category
    @categor = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :icone).merge(author_id: current_user.id)
  end
end
