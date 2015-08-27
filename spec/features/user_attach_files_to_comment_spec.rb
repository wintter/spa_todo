feature 'attach files', js: true do
  given(:user) { FactoryGirl.create(:user) }
  given!(:project) { FactoryGirl.create(:project, user: user, name: 'test project') }
  given!(:task_list) { FactoryGirl.create(:task_list, project: project) }
  given!(:comment) { FactoryGirl.create(:comment, task_list: task_list) }

  before do
    login_as user, scope: :user
    visit '/#/'
    @file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test.txt'), 'text/plain')
  end

  scenario 'user attach files to comment' do
    find('.button_upload').set(@file)
    save_screenshot('./spec/screen/files.png')
  end

end