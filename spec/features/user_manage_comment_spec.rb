feature 'comment', js: true do
  given(:user) { FactoryGirl.create(:user) }
  given!(:project) { FactoryGirl.create(:project, user: user, name: 'test project') }
  given!(:task_list) { FactoryGirl.create(:task_list, project: project) }
  given!(:comment) { FactoryGirl.create(:comment, task_list: task_list) }

  before do
    login_as user, scope: :user
    visit '/#/'
  end

  scenario 'user add new comment to task' do
    find('#add_comment').click
    find('#new_comment').set 'test comment'
    click_button 'Add comment'
    expect(page).to have_content 'test comment'
  end

  scenario 'user can delete comment from project' do
    find('#remove_comment').click
    expect(page).not_to have_content comment.name
  end

  scenario 'user can edit comment' do
    find('#update_comment').click
    find('.editable-input').set 'new comment name'
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content 'new comment name'
  end

  scenario 'user leave the comment name field empty' do
    find('#update_comment').click
    find('.editable-input').set ''
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content 'Comment has not been updated'
  end

end