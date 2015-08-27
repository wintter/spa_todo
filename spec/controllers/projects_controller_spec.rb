require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  let(:project) { FactoryGirl.create(:project) }
  let(:project_attr) { FactoryGirl.attributes_for(:project) }

  describe 'GET #index' do
    before { project; get :index }

    context 'cancan doesnt allow :index' do
      before do
        ability.cannot :index, Project
        get :index
      end
      it { expect(response).to redirect_to(root_path) }
    end

    it { expect(response).to have_http_status(200) }

    it 'generate @projects' do
      expect(assigns(:projects)).not_to be_nil
    end

  end

  describe 'POST #create' do

    context 'cancan doesnt allow :create' do
      before do
        ability.cannot :create, Project
        post :create, name: project.name
      end
      it { expect(response).to redirect_to(root_path) }
    end

    context 'success save' do
      before { post :create, name: project.name }

      it 'generate @project' do
        expect(assigns(:project)).not_to be_nil
      end

      it '#save project' do
        expect(assigns(:project)).to receive(:save).and_return(true)
        post :create, name: project.name
      end
    end

    context 'invalid save' do
      before do
        post :create, name: nil
      end

      it 'generate fail message' do
        expect(response_body['message']).to eq I18n.t('project.error_save')
      end

    end

  end

  describe 'POST #update' do

    context 'success update' do
      before { patch :update, id: project.id, name: 'new name' }

      context 'cancan doesnt allow :update' do
        before do
          ability.cannot :update, Project
          patch :update, id: project.id, name: 'new name'
        end
        it { expect(response).to redirect_to(root_path) }
      end

      it 'generate @project' do
        expect(assigns(:project)).not_to be_nil
      end

      it '#update project' do
        expect(assigns(:project)).to receive(:update).with(project_attr).and_return(true)
        patch :update, id: project.id, name: project.name
      end
    end

    context 'invalid update' do
      before do
        patch :update, id: project.id, name: nil
      end

      it 'generate fail message' do
        expect(response_body['message']).to eq I18n.t('project.error_update')
      end
    end
  end

  describe 'POST #destroy' do
    before { delete :destroy, id: project.id }

    context 'cancan doesnt allow :destroy' do
      before do
        ability.cannot :destroy, Project
        delete :destroy, id: project.id
      end
      it { expect(response).to redirect_to(root_path) }
    end

    it 'generate @project' do
      expect(assigns(:project)).not_to be_nil
    end

    it '#destroy project' do
      expect(assigns(:project)).to receive(:destroy).and_return(true)
      delete :destroy, id: project.id
    end

  end

  def response_body
    JSON.parse(response.body)
  end

end
