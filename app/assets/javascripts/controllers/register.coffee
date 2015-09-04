controllers = angular.module('todo_list')

controllers.controller 'RegisterController', [
	'$scope'
	'$http'
	'Auth'
	'$location'
	($scope, $http, Auth, $location) ->
		config = headers: 'X-HTTP-Method-Override': 'POST'

		$scope.register = (data) ->
			Auth.register(data, config).then ((registeredUser) ->
				#user register
			), (error) ->
				$('.alert_error').html '<div class="alert alert-danger opensans" role="alert">Registration failed</div>'

		$scope.$on 'devise:new-registration', (event, user) ->
			$location.path '/'
]