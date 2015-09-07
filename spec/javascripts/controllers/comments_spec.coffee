#= require spec_helper
describe 'CommentsController', ->
  beforeEach ->
    @task_with_comments =  id: 1, name: 'first task', comments: [ { id: 1, name: 'first comments' }]
    @scope.task = @task_with_comments
    @controller('CommentsController', { $scope: @scope, $http: @http })

  describe 'addComments', ->
	  beforeEach ->
		  @scope.commentText = 'test comment'

    it 'create new comment', ->
      @http.expectPOST('/comments?name=test+comment&task_list_id=1').respond(200, '')
      @scope.addComments(1)
      @http.flush()

    it 'increased comments by 1', ->
      @http.whenPOST('/comments?name=New+comment&task_list_id=1').respond(200, '')
      @scope.addComments(1)
      @http.flush()
      expect(@scope.task.comments.length).toEqual(2)

  describe 'updateComment', ->
    it 'update comment by name', ->
      @new_name = 'NewCommentName'
      @http.expectPATCH('/comments/1?name=' + @new_name).respond(200, '')
      @scope.updateComment(@new_name, 1)
      @http.flush()

  describe 'removeComment', ->
    beforeEach ->
      @key = 0

    it 'remove comment', ->
      @http.expectDELETE('/comments/1').respond(200, '')
      @scope.removeComment(1, @key)
      @http.flush()

    it 'remove comment from display list', ->
      @http.whenDELETE('/comments/1').respond(200, '')
      @scope.removeComment(1, @key)
      @http.flush()
      expect(@scope.task.comments.length).toEqual(0)
