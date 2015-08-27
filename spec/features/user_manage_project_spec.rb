feature 'project', js: true do
  given(:user) { FactoryGirl.create(:user) }
  given!(:project) { FactoryGirl.create(:project, user: user, name: 'test project') }

  before do
    login_as user, scope: :user
    visit '/#/'
  end

  scenario 'user sign in and sees \'Add todo\' button' do
    expect(page).to have_content('Add todo')
  end

  scenario 'user press \'Add Todo\' button and create new project' do
    find('.todo_button').click
    expect(page).to have_content('New Project')
  end

  scenario 'user can delete his projects' do
    find('#remove_project').click
    expect(page).not_to have_content project.name
  end

  scenario 'user can edit project name' do
    find('.name_project').click
    find('.editable-input').set 'new name'
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content 'new name'
  end

end