feature 'project', js: true do
  given(:user) { FactoryGirl.create(:user) }
  given!(:project) { FactoryGirl.create(:project, user: user, name: 'test project') }

  before do
    login_as user, scope: :user
    visit '/#/'
  end

  scenario 'user press \'Add Todo\' button and create new project' do
    find('.todo_button').click
    find('#new_project').set 'test project'
    click_button 'Add project'
    expect(page).to have_content('test project')
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

  scenario 'user leave the project name field empty' do
    find('.name_project').click
    find('.editable-input').set ''
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content 'Project has not been updated'
  end

end