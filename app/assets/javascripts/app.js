todo_list = angular.module('todo_list',[
  'ngRoute',
  'ngResource',
  'templates',
  'controllers',
  'xeditable',
  'ui.bootstrap',
  'ui.sortable',
  '720kb.tooltips',
  'Devise',
  'ngFileUpload'
]);

controllers = angular.module('controllers',[]);

todo_list.run(function(editableOptions) {
    editableOptions.theme = 'bs3';
});

todo_list.config(['$routeProvider', function($routeProvider) {
        $routeProvider.
            when('/', {
                controller:  'ProjectsController',
                templateUrl: 'index.html'
            }).
            when('/login', {
                controller:  'SignInController',
                templateUrl: 'login.html'
            }).
            otherwise({
                redirectTo: '/'
            });
    }]);
