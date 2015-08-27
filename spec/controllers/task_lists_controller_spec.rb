require 'rails_helper'

RSpec.describe TaskListsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  let(:task_list) { FactoryGirl.create(:task_list) }

  describe 'GET #index' do
    before { task_list; get :index }

    context 'cancan doesnt allow :index' do
      before do
        ability.cannot :index, TaskList
        get :index
      end
      it { expect(response).to redirect_to(root_path) }
    end

    it { expect(response).to have_http_status(200) }

    xit 'generate @task_lists' do
      expect(assigns(:task_lists)).not_to be_nil
    end

  end

  describe 'POST #create' do

    context 'cancan doesnt allow :create' do
      before do
        ability.cannot :create, TaskList
        post :create, name: task_list.name
      end
      it { expect(response).to redirect_to(root_path) }
    end

    context 'success save' do
      before { post :create, name: task_list.name }

      it 'generate @task_list' do
        expect(assigns(:task_list)).not_to be_nil
      end

      it '#save task_list' do
        expect(assigns(:task_list)).to receive(:save).and_return(true)
        post :create, name: task_list.name
      end
    end

    context 'invalid save' do
      before do
        post :create, name: nil
      end

      it 'generate fail message' do
        expect(response_body['message']).to eq I18n.t('task_list.error_save')
      end

    end

  end

  describe 'POST #update' do

    context 'success update' do
      before { patch :update, id: task_list.id, name: 'new name' }

      context 'cancan doesnt allow :update' do
        before do
          ability.cannot :update, TaskList
          patch :update, id: task_list.id, name: 'new name'
        end
        it { expect(response).to redirect_to(root_path) }
      end

      it 'generate @task_list' do
        expect(assigns(:task_list)).not_to be_nil
      end

      it '#update task_list' do
        expect(assigns(:task_list)).to receive(:update).with(name: task_list.name).and_return(true)
        patch :update, id: task_list.id, name: task_list.name
      end
    end

    context 'invalid update' do
      before do
        patch :update, id: task_list.id, name: nil
      end

      it 'generate fail message' do
        expect(response_body['message']).to eq I18n.t('task_list.error_update')
      end
    end
  end

  describe 'POST #destroy' do
    before { delete :destroy, id: task_list.id }

    context 'cancan doesnt allow :destroy' do
      before do
        ability.cannot :destroy, TaskList
        delete :destroy, id: task_list.id
      end
      it { expect(response).to redirect_to(root_path) }
    end

    it 'generate @task_list' do
      expect(assigns(:task_list)).not_to be_nil
    end

    it '#destroy task_list' do
      expect(assigns(:task_list)).to receive(:destroy).and_return(true)
      delete :destroy, id: task_list.id
    end

  end

  def response_body
    JSON.parse(response.body)
  end

end
