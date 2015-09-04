controllers = angular.module('todo_list')

controllers.controller 'SignInController', [
	'$scope'
	'$http'
	'Auth'
	'$location'
	($scope, $http, Auth, $location) ->
		config = headers: 'X-HTTP-Method-Override': 'POST'
		Auth.currentUser().then ((user) ->
			$location.path '/'
			# User was logged in, or Devise returned
			# previously authenticated session.
		), (error) ->
			# unauthenticated error

		$scope.login = (data) ->
			Auth.login(data, config).then ((user) ->
				#console.log(user);
			), (error) ->
				$('.alert_error').html '<div class="alert alert-danger opensans" role="alert">' + error.data.error + '</div>'

		$scope.logout = ->
			config = headers: 'X-HTTP-Method-Override': 'DELETE'
			Auth.logout(config).then ((oldUser) ->
				# alert(oldUser.name + "you're signed out now.");
			), (error) ->
				# An error occurred logging out.

		$scope.$on 'devise:login', (event, currentUser) ->
			$location.path '/'
		# after a login, a hard refresh, a new tab
		$scope.$on 'devise:logout', (event, oldCurrentUser) ->
			$location.path '/login'
		$scope.$on 'devise:new-session', (event, currentUser) ->
			#$location.path("/");
]
