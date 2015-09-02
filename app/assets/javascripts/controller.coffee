controllers = angular.module('controllers',[]);

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
        alertFactory.showError(res.message) if res.message

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

controllers.controller 'ProjectsController', [
  '$scope'
  '$http'
  'Project'
  'Projects'
  'CheckLogin',
	'alertFactory',
  ($scope, $http, Project, Projects, CheckLogin, alertFactory) ->
    CheckLogin()
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
	      alertFactory.showError(res.message) if res.message

    $scope.removeProject = (id, key) ->
      Project.destroy { id: id }, ->
        $scope.projects.splice key, 1
]


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
	      alertFactory.showError(res.message) if res.message

    $scope.removeComment = (id, key) ->
      Comment.destroy { id: id }, ->
        $scope.task.comments.splice key, 1
]


controllers.controller 'UploadController', [
  '$scope'
  'Upload'
  '$timeout'
  ($scope, Upload, $timeout) ->

    $scope.uploadFiles = (files, comment_id) ->
      $scope.files = files
      angular.forEach files, (file) ->
        if file and !file.$error
          file.upload = Upload.upload(
            url: '/comments/' + comment_id + '/attach_files'
            file: file)
          file.upload.then ((response) ->
            $timeout ->
              file.result = response.data
          ), (response) ->
            if response.status > 0
              $scope.errorMsg = response.status + ': ' + response.data
          file.upload.progress (evt) ->
            file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total))
]


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
        $('.alert_error').append '<div class="alert alert-danger opensans" role="alert">Registration failed</div>'

    $scope.$on 'devise:new-registration', (event, user) ->
      $location.path '/'
]