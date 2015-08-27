require 'rails_helper'

RSpec.describe TaskList, type: :model do

  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to belong_to(:project) }
  it { expect(subject).to have_many(:comments) }

end
