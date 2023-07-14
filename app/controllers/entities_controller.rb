class EntitiesController < ApplicationController
  before_action :set_category
  before_action :set_user

  def index
    @entities = Entity.all
  end

  def show; end

  def edit; end

  def new
    @categories = @user.categories.includes(:entities)
    @entity = Entity.new
  end

  def create
    category_ids = entity_params[:category_ids]
    if category_ids.blank?
      redirect_to new_category_entity_path
      flash[:notice] = 'Please select a category'
      return
    end

    category_ids.each do |category_id|
      @entity = Entity.new(entity_params)
      @entity.author_id = @user.id
      @entity.category_ids = [category_id]

      if @entity.valid? && @entity.save
        redirect_to category_entities_url(@entity)
        flash[:notice] = 'Entity created successfully'
      else
        puts @entity.errors.full_messages
        flash[:notice] = 'Entity could not be created successfully'
        render :new
      end
    end
  end

  def update
    if @entity.update(entity_params)
      redirect_to entity_url(@entity)
      flash[:notice] = 'entity was updated successfully'
    else
      flash[:notice] = 'entity couldnt updated successfully'
      render :edit
    end
  end

  def destroy
    @entity.destroy
    redirect_to entities_url
    flash[:notice] = 'entity was successfully destroy'
  end

  private

  def set_category
    # @entity = Entity.find(params[:id])

    @category = Category.find(params[:category_id])
  end

  def set_user
    @user = current_user
  end

  def entity_params
    params.require(:entity).permit(:name, :amount, category_ids: [])
  end
end
