controllers = angular.module('todo_list')

controllers.controller 'CommentsController', [
	'$scope'
	'$http'
	'Comment'
	'Comments'
	'alertFactory'
	'ngDialog'
	($scope, $http, Comment, Comments, alertFactory, ngDialog) ->

		$scope.addComments = (task_id) ->
			Comments.create {
				task_list_id: task_id
				name: $scope.commentText
			}, (res) ->
				if res.message
					$('.error_comment').html '<div class="alert alert-warning">' + res.message + '</div>'
				else
					$scope.closeThisDialog(res.comment)

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

		$scope.clickToOpen = () ->
			modal = ngDialog.open
				template: 'popup_comment.html',
				scope: $scope
			modal.closePromise.then (res) ->
				if typeof res.value == 'object'
					$scope.task.comments.push res.value
					$scope.commentText = ''
]
