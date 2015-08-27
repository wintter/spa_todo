require 'rails_helper'

RSpec.describe Ability, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:another_user) { FactoryGirl.create(:user) }

  subject { Ability.new(user) }

  context 'Task list' do
    let(:project) { FactoryGirl.create(:project, user: user) }
    let(:another_project) { FactoryGirl.create(:project, user: another_user) }

    it { expect(subject).to be_able_to(:index, TaskList.new(project: project)) }
    it { expect(subject).to be_able_to(:create, TaskList.new(project: project)) }
    it { expect(subject).to be_able_to(:update, TaskList.new(project: project)) }
    it { expect(subject).to be_able_to(:destroy, TaskList.new(project: project)) }

    it { expect(subject).not_to be_able_to(:index, TaskList.new(project: another_project)) }
    it { expect(subject).not_to be_able_to(:create, TaskList.new(project: another_project)) }
    it { expect(subject).not_to be_able_to(:update, TaskList.new(project: another_project)) }
    it { expect(subject).not_to be_able_to(:destroy, TaskList.new(project: another_project)) }
  end

  context 'Project' do
    it { expect(subject).to be_able_to(:index, Project.new(user: user)) }
    it { expect(subject).to be_able_to(:create, Project.new(user: user)) }
    it { expect(subject).to be_able_to(:update, Project.new(user: user)) }
    it { expect(subject).to be_able_to(:destroy, Project.new(user: user)) }

    it { expect(subject).not_to be_able_to(:index, Project.new(user: another_user)) }
    it { expect(subject).not_to be_able_to(:create, Project.new(user: another_user)) }
    it { expect(subject).not_to be_able_to(:update, Project.new(user: another_user)) }
    it { expect(subject).not_to be_able_to(:destroy, Project.new(user: another_user)) }
  end

  context 'Comment' do
    let(:comment) { FactoryGirl.create(:comment) }
    before { comment.task_list.project.update(user: user) }

    it { expect(subject).to be_able_to(:create, comment) }
    it { expect(subject).to be_able_to(:update, comment) }
    it { expect(subject).to be_able_to(:destroy, comment) }
  end

end
