controllers = angular.module('todo_list')

controllers.controller 'ProjectsController', [
	'$scope'
	'$http'
	'Project'
	'Projects'
	'CheckLogin',
	'alertFactory',
	($scope, $http, Project, Projects, CheckLogin, alertFactory) ->

		Projects.get (response) ->
			$scope.projects = response.projects

		$scope.createProject = ->
			Projects.create { name: 'New Project' }, (res) ->
				if !res.message
					$scope.projects.unshift res.project
					$scope.projectText = ''

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
]

