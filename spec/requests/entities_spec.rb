require 'rails_helper'

RSpec.describe EntitiesController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:valid_entity_params) { { name: 'Test Entity', amount: 100, category_ids: [category.id] } }
  let(:invalid_entity_params) { { name: '', amount: 100, category_ids: [category.id] } }

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new entity' do
        sign_in user
        expect do
          post :create, params: { entity: valid_entity_params }
        end.to change(Entity, :count).by(1)
      end

      it 'redirects to the category_entities_url' do
        sign_in user
        post :create, params: { entity: valid_entity_params }
        expect(response).to redirect_to(category_entities_url(assigns(:entity)))
      end

      it 'sets a success flash notice' do
        sign_in user
        post :create, params: { entity: valid_entity_params }
        expect(flash[:notice]).to eq('Entity created successfully')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new entity' do
        sign_in user
        expect do
          post :create, params: { entity: invalid_entity_params }
        end.not_to change(Entity, :count)
      end

      it 'renders the new template' do
        sign_in user
        post :create, params: { entity: invalid_entity_params }
        expect(response).to render_template(:new)
      end

      it 'sets a flash notice for the failure' do
        sign_in user
        post :create, params: { entity: invalid_entity_params }
        expect(flash[:notice]).to eq('Entity could not be created successfully')
      end
    end
  end
end
