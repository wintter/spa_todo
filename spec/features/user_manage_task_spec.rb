feature 'task', js: true do
  given(:user) { FactoryGirl.create(:user) }
  given!(:project) { FactoryGirl.create(:project, user: user, name: 'test project') }
  given!(:task_list) { FactoryGirl.create(:task_list, project: project) }

  before do
    login_as user, scope: :user
    visit '/#/'
  end

  scenario 'user fill in task name and press \' Add task \' button' do
    find('.input_new_task').set 'new task'
    click_on('Add Task')
    expect(page).to have_content 'new task'
    expect(page).to have_content 'Add comment'
    expect(page).to have_css('.glyphicon-time')
    expect(page).to have_css('#remove_task')
  end

  scenario 'user can delete task from project' do
    find('#remove_task').click
    expect(page).not_to have_content task_list.name
  end

  scenario 'user want to be able mark task as done' do
    find('#task_status').set true
    expect(page).to have_css('.done')
  end

  scenario 'user can edit task name' do
    find('.task_name').click
    find('.editable-input').set 'new task name'
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content 'new task name'
  end

  scenario 'user want set task deadline' do
    find('#task_deadline').click
    find('.editable-input').set Date.new(2015, 1, 1), format: '%Y-%m-%d'
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content '01.01'
  end

  scenario 'user leave the task name field empty' do
    find('.task_name').click
    find('.editable-input').set ''
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content 'Task has not been updated'
  end

end