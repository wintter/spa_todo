require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  let(:comment) { FactoryGirl.create(:comment) }

  describe 'POST #create' do

    context 'cancan doesnt allow :create' do
      before do
        ability.cannot :create, Comment
        post :create, name: comment.name
      end
      it { expect(response).to redirect_to(root_path) }
    end

    context 'success save' do
      before { post :create, name: comment.name }

      it 'generate @comment' do
        expect(assigns(:comment)).not_to be_nil
      end

      it '#save comment' do
        expect(assigns(:comment)).to receive(:save).and_return(true)
        post :create, name: comment.name
      end
    end

    context 'invalid save' do
      before do
        post :create, name: nil
      end

      it 'generate fail message' do
        expect(response_body['message']).to eq I18n.t('comment.error_save')
      end

    end

  end

  describe 'POST #update' do

    context 'success update' do
      before { patch :update, id: comment.id, name: 'new name' }

      context 'cancan doesnt allow :update' do
        before do
          ability.cannot :update, Comment
          patch :update, id: comment.id, name: 'new name'
        end
        it { expect(response).to redirect_to(root_path) }
      end

      it 'generate @comment' do
        expect(assigns(:comment)).not_to be_nil
      end

      it '#update comment' do
        expect(assigns(:comment)).to receive(:update).with(name: comment.name).and_return(true)
        patch :update, id: comment.id, name: comment.name
      end
    end

    context 'invalid update' do
      before do
        patch :update, id: comment.id, name: nil
      end

      it 'generate fail message' do
        expect(response_body['message']).to eq I18n.t('comment.error_update')
      end
    end
  end

  describe 'POST #destroy' do
    before { delete :destroy, id: comment.id }

    context 'cancan doesnt allow :destroy' do
      before do
        ability.cannot :destroy, Comment
        delete :destroy, id: comment.id
      end
      it { expect(response).to redirect_to(root_path) }
    end

    it 'generate @comment' do
      expect(assigns(:comment)).not_to be_nil
    end

    it '#destroy comment' do
      expect(assigns(:comment)).to receive(:destroy).and_return(true)
      delete :destroy, id: comment.id
    end

  end

  def response_body
    JSON.parse(response.body)
  end

end
