controllers = angular.module('todo_list')

controllers.controller 'CommentsController', [
	'$scope'
	'$http'
	'Comment'
	'Comments',
	'alertFactory',
	($scope, $http, Comment, Comments, alertFactory) ->

		$scope.addComments = (task_id) ->
			Comments.create {
				task_list_id: task_id
				name: 'New comment'
			}, (res) ->
				if !res.message
					$scope.task.comments.push res.comment

		$scope.updateComment = (data, id) ->
			Comment.update {
				id: id
				name: data
			}, (res) ->
				if res.message
					alertFactory.showError(res.message)

		$scope.removeComment = (id, key) ->
			Comment.destroy { id: id }, ->
				$scope.task.comments.splice key, 1
]
