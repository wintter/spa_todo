todo_list = angular.module('todo_list')

todo_list.factory 'Projects', [
  '$resource'
  ($resource) ->
    $resource '/projects', {},
      'get': method: 'GET'
      'create':
        method: 'POST'
        params: name: '@name'
]

todo_list.factory 'Project', [
  '$resource'
  ($resource) ->
    $resource '/projects/:id', {},
      'update':
        method: 'PATCH'
        params:
          id: '@id'
          name: '@name'
      'destroy':
        method: 'DELETE'
        params: id: '@id'
]

todo_list.factory 'TaskLists', [
  '$resource'
  ($resource) ->
    $resource '/task_lists', {}, 'create':
      method: 'POST'
      params:
        project_id: '@project_id'
        name: '@name'
        status: '@status'
]

todo_list.factory 'TaskList', [
  '$resource'
  ($resource) ->
    $resource '/task_lists/:id', {},
      'update':
        method: 'PATCH'
        params:
          id: '@id'
          name: '@name'
          status: '@status'
          deadline: '@deadline'
          position: '@position'
      'destroy':
        method: 'DELETE'
        params: id: '@id'
]

todo_list.factory 'Comments', [
  '$resource'
  ($resource) ->
    $resource '/comments', {}, 'create':
      method: 'POST'
      params:
        task_list_id: '@task_list_id'
        name: '@name'
]

todo_list.factory 'Comment', [
  '$resource'
  ($resource) ->
    $resource '/comments/:id', {},
      'update':
        method: 'PATCH'
        params:
          id: '@id'
          name: '@name'
      'destroy':
        method: 'DELETE'
        params: id: '@id'
]

todo_list.factory 'CheckLogin', [
  'Auth'
  '$location'
  (Auth, $location) ->
    ->
      if !Auth.isAuthenticated()
        $location.path '/login'
]

todo_list.factory 'alertFactory',[
	'$timeout'
	($timeout) ->
		showError: (message) ->
			$('.error_messages_list').html '<div class="alert alert-warning">' + message + '</div>'
			$timeout(->
				$('.error_messages_list').html('')
			2000)
]