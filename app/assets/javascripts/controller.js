controllers.controller('TaskListsController', ['$scope', '$http', 'TaskLists', 'TaskList', 'orderByFilter',
    function($scope, $http, TaskLists, TaskList, orderByFilter) {

        angular.forEach($scope.project.task_lists, function(value, key){
            value.deadline = new Date(value.deadline);
        });

        $scope.createTask = function(project_id) {
            TaskLists.create({ project_id: project_id, name: $scope.todoText }, function(res) {
                $scope.project.task_lists.push(res.task_list);
                $scope.todoText = '';
            });
        };

        $scope.updateTask = function(data, id) {
            TaskList.update({ id: id, name: data });
        };

        $scope.updateDateTask = function(data, id) {
            TaskList.update({ id: id, deadline: data });
        };

        $scope.changeStatus = function(task_id, stat, key) {
            TaskList.update({ id: task_id, status: !stat }, function(){
                $scope.project.task_lists[key].status = !stat;
            });
        };

        $scope.removeTask = function(id, key) {
            TaskList.destroy({ id: id }, function() {
                $scope.project.task_lists.splice(key, 1);
            });
        };

        $scope.sortableOptions = {
            stop: function(e, ui) {
                angular.forEach($scope.project.task_lists, function(value, key) {
                    TaskList.update({ id: value.id, position: key });
                });
            }
        };

        angular.forEach($scope.projects, function(value, key) {
            $scope.$watchCollection(value, function () {
                $scope.projects[key].task_lists = orderByFilter($scope.projects[key].task_lists, ['position']);
            });
        });

    }
]);

controllers.controller('ProjectsController', ['$scope', '$http', 'Project', 'Projects',
    function ($scope, $http, Project, Projects) {

        Projects.get(function(response){
            $scope.projects = response.projects;
            console.log(response);
        });

        $scope.createProject = function() {
            Projects.create({ name: 'New Project' }, function(res) {
                $scope.projects.unshift(res.project);
                $scope.projectText = '';
            });
        };

        $scope.updateProject = function(data, id) {
            Project.update({ id: id, name: data }, function(response) {
                if(response.message) {
                    $('.error_messages_list').append('<div class="alert alert-warning">'+ response.message + '</div>')
                }
            });
        };

        $scope.removeProject = function(id, key) {
            Project.destroy({ id: id }, function() {
                $scope.projects.splice(key, 1);
            });
        };
    }
]);

controllers.controller('CommentsController', ['$scope', '$http', 'Comment', 'Comments',
    function ($scope, $http, Comment, Comments) {

        $scope.addComments = function(task_id) {
            Comments.create({ task_list_id: task_id, name: 'New comment' }, function(res) {
                $scope.task.comments.push(res);
            });
        };

        $scope.updateComment = function (data, id) {
            Comment.update({id: id, name: data});
        };

        $scope.removeComment = function(id, key) {
            Comment.destroy({id: id}, function() {
                $scope.task.comments.splice(key, 1);
            });
        }


    }]);

controllers.controller('UploadController', ['$scope', 'Upload', '$timeout',
    function($scope, Upload, $timeout) {
        $scope.uploadFiles = function(files, comment_id) {
            $scope.files = files;
            angular.forEach(files, function (file) {
                if (file && !file.$error) {
                    file.upload = Upload.upload({
                        url: '/comments/' + comment_id + '/attach_files',
                        file: file
                    });

                    file.upload.then(function (response) {
                        $timeout(function () {
                            file.result = response.data;
                        });
                    }, function (response) {
                        if (response.status > 0)
                            $scope.errorMsg = response.status + ': ' + response.data;
                    });

                    file.upload.progress(function (evt) {
                        file.progress = Math.min(100, parseInt(100.0 *
                        evt.loaded / evt.total));
                    });
                }
            });
        }
    }]);

controllers.controller('SignInController', ['$scope', '$http', 'Auth', '$location',
    function ($scope, $http, Auth, $location) {

        Auth.currentUser().then(function(user) {
            $location.path("/");
            // User was logged in, or Devise returned
            // previously authenticated session.
        }, function(error) {
            // unauthenticated error
        });

        $scope.login = function(data) {
            var config = { headers: { 'X-HTTP-Method-Override': 'POST' } };

            Auth.login(data, config).then(function(user) {
                //console.log(user);
            }, function(error) {
                $('.alert_error').append('<div class="alert alert-danger opensans" role="alert">' + error.data.error + '</div>');
            });
        };

        $scope.$on('devise:login', function(event, currentUser) {
            $location.path("/");
            // after a login, a hard refresh, a new tab
        });

        $scope.$on('devise:new-session', function(event, currentUser) {
            //$location.path("/");
        });
    }
]);
