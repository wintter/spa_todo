#= require spec_helper
describe 'TaskListsController', ->
  beforeEach ->
    @project_with_task =  id: 1, name: 'first projects', task_lists: [ { id: 1, name: 'first task' }]
    @scope.project = @project_with_task
    @controller('TaskListsController', { $scope: @scope, $http: @http })

  describe 'load', ->
    it 'sets up the list of tasks', ->
      expect(@scope.project.task_lists.length).toEqual(1)

    it 'sort task by position', ->
      @first_task = { id: 1, name: 'first task', position: '2' }
      @second_task = { id: 2, name: 'second task', position: '1' }
      @scope.projects = [ id: 1, name: 'first projects', task_lists: [ @first_task , @second_task ] ]
      @controller('TaskListsController', { $scope: @scope })
      #expect(@scope.projects[0].task_lists[0]).toEqual(@second_task)

  describe 'createTask', ->
    beforeEach ->
      @scope.todoText = '1234'

    it 'creates a new task', ->
      @http.expectPOST('/task_lists?name=1234&project_id=1').respond(200, { task_list: id: 2, name: '1234' })
      @scope.createTask(1)
      @http.flush()

    it 'increased tasks by 1', ->
      @http.whenPOST('/task_lists?name=1234&project_id=1').respond(200, { task_list: id: 2, name: '1234' })
      @scope.createTask(1)
      @http.flush()
      expect(@scope.project.task_lists.length).toEqual(2)

    it 'clean task name input after save', ->
      @http.whenPOST('/task_lists?name=1234&project_id=1').respond(200, { task_list: id: 2, name: '1234' })
      @scope.createTask(1)
      @http.flush()
      expect(@scope.todoText).toEqual('')

  describe 'updateTask', ->
    it 'update task by name', ->
      @http.expectPATCH('/task_lists/1?name=new+name+task').respond(200, '')
      @scope.updateTask('new name task', 1)
      @http.flush()

  describe 'updateDate', ->
    it 'update task by date', ->
      date = new Date();
      date = date.setDate(date.getDate() - 1);
      @http.expectPATCH('/task_lists/1?deadline=' + date).respond(200, '')
      @scope.updateDateTask(date, 1)
      @http.flush()

  describe 'changeStatus', ->
    beforeEach ->
      @key = 0

    it 'update task status from true to false', ->
      @http.expectPATCH('/task_lists/1?status=true').respond(200, '')
      @scope.changeStatus(1, false, @key)
      @http.flush()

    it 'update task status from false to true', ->
      @http.expectPATCH('/task_lists/1?status=false').respond(200, '')
      @scope.changeStatus(1, true, @key)
      @http.flush()

    it 'switch status in display list', ->
      @http.whenPATCH('/task_lists/1?status=false').respond(200, '')
      @scope.changeStatus(1, true, @key)
      @http.flush()
      expect(@scope.project.task_lists[@key].status).toEqual(false)

  describe 'removeTask', ->
    beforeEach ->
      @key = 0

    it 'remove task', ->
      @http.expectDELETE('/task_lists/1').respond(200, '')
      @scope.removeTask(1, @key)
      @http.flush()

    it 'remove task from display list', ->
      @http.whenDELETE('/task_lists/1').respond(200, '')
      @scope.removeTask(1, @key)
      @http.flush()
      expect(@scope.project.task_lists.length).toEqual(0)

  describe 'sortableOptions', ->
    it 'update all task', ->
      @key = 0
      @http.expectPATCH('/task_lists/1?position=' + @key).respond(200, '')
      @scope.sortableOptions.stop()
      @http.flush()