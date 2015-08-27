require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to belong_to(:task_list) }

  describe '#comment_user' do
    let(:subject) { FactoryGirl.create(:comment) }

    it 'return user' do
      expect(subject.comment_user).to be_an_instance_of User
    end

  end

end
