require 'rails_helper'

RSpec.describe TaskList, type: :model do

  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to belong_to(:project) }
  it { expect(subject).to have_many(:comments) }

  describe '#task_user' do
    let(:subject) { FactoryGirl.create(:task_list) }

    it 'return user' do
      expect(subject.task_user).to be_an_instance_of User
    end

  end

end
