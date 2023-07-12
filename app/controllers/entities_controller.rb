class EntitiesController <ApplicationController
     before_action :set_entity, only: [:show, :edit, :update, :destroy]

     def index
        @entities=Entity.all
     end

     def show 
     end
     def edit 
     end

     def new
        @entity=Entity.new
     end

     def create
        @entity=Entity.new(entity_params)
        if @entity.save
            redirect_to entity_url(@entity), notice: 'Entity created successfully'
        else
            render :new
        end
     end

     def update
        if @entity.update(entity_params)
            redirect_to entity_url(@entity), notice: "entity was updated successfully"
        else
            render :edit
     end

     def destroy 
        @entity.destroy
        redirect_to entities_url, notice: 'entity was successfully destroy'
     end
      

     private
      def set_entity
        @entity=Entity.find(params[:id])
      end

      def entity_params
        params.require(:entity).permit(:name, :amount)
      end
end