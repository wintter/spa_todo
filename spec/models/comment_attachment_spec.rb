require 'rails_helper'

RSpec.describe CommentAttachment, type: :model do
  it { expect(subject).to belong_to(:project) }
end
