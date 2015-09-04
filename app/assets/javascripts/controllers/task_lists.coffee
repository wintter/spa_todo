controllers = angular.module('todo_list')

controllers.controller 'TaskListsController', [
	'$scope'
	'$http'
	'TaskLists'
	'TaskList'
	'orderByFilter',
	'$timeout',
	'alertFactory',
	($scope, $http, TaskLists, TaskList, orderByFilter, $timeout, alertFactory) ->
		angular.forEach $scope.project.task_lists, (value, key) ->
			value.deadline = new Date(value.deadline)

		$scope.createTask = (project_id) ->
			TaskLists.create {
				project_id: project_id
				name: $scope.todoText
			}, (res) ->
				if res.message
					alertFactory.showError(res.message)

				else
					$scope.project.task_lists.push res.task_list
					$scope.todoText = ''

		$scope.updateTask = (data, id) ->
			TaskList.update {
				id: id
				name: data
			}, (res) ->
				if res.message
					$('.error_messages_list').html '<div class="alert alert-warning">' + res.message + '</div>'

		$scope.updateDateTask = (data, id) ->
			TaskList.update
				id: id
				deadline: data

		$scope.changeStatus = (task_id, stat, key) ->
			TaskList.update {
				id: task_id
				status: !stat
			}, ->
				$scope.project.task_lists[key].status = !stat

		$scope.removeTask = (id, key) ->
			TaskList.destroy { id: id }, ->
				$scope.project.task_lists.splice key, 1

		$scope.sortableOptions = stop: (e, ui) ->
			angular.forEach $scope.project.task_lists, (value, key) ->
				TaskList.update
					id: value.id
					position: key

		angular.forEach $scope.projects, (value, key) ->
			$scope.$watchCollection value, ->
				$scope.projects[key].task_lists = orderByFilter($scope.projects[key].task_lists, [ 'position' ])
]