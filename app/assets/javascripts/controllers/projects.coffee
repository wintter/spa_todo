controllers = angular.module('todo_list')

controllers.controller 'ProjectsController', [
	'$scope'
	'$http'
	'Project'
	'Projects'
	'CheckLogin'
	'alertFactory'
	'$timeout'
	'ngDialog'
	($scope, $http, Project, Projects, CheckLogin, alertFactory, $timeout, ngDialog) ->
		$timeout(->
			CheckLogin()
		200)
		Projects.get (response) ->
			$scope.projects = response.projects

		$scope.createProject = ->
			Projects.create { name: $scope.projectText }, (res) ->
				if res.message
					$('.error_project').html '<div class="alert alert-warning">' + res.message + '</div>'
				else
					$scope.closeThisDialog(res.project)

		$scope.updateProject = (data, id) ->
			Project.update {
				id: id
				name: data
			}, (res) ->
				if res.message
					alertFactory.showError(res.message)

		$scope.removeProject = (id, key) ->
			Project.destroy { id: id }, ->
				$scope.projects.splice key, 1

		$scope.clickToOpen = () ->
			modal = ngDialog.open
				template: 'popup_project.html',
				scope: $scope
			modal.closePromise.then (res) ->
				if typeof res.value == 'object'
					$scope.projects.push(res.value)
					$scope.projectText = ''

]

