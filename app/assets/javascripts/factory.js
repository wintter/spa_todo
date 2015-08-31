todo_list.factory('Projects', ['$resource', function($resource) {
    return $resource('/projects', {},
        {
            'get': { method: 'GET' },
            'create': { method: 'POST', params: { name: '@name' } }
        });
}]);

todo_list.factory('Project', ['$resource', function($resource) {
    return $resource('/projects/:id', {},
        {
            'update': { method: 'PATCH', params: { id: '@id', name: '@name' } },
            'destroy': { method: 'DELETE', params: { id: '@id' } }
        });
}]);

todo_list.factory('TaskLists', ['$resource', function($resource) {
    return $resource('/task_lists', {},
        {
            'create': { method: 'POST', params: { project_id: '@project_id', name: '@name', status: '@status' } }
        });
}]);

todo_list.factory('TaskList', ['$resource', function($resource) {
    return $resource('/task_lists/:id', {},
        {
            'update': { method: 'PATCH', params: { id: '@id', name: '@name', status: '@status', deadline: '@deadline', position: '@position' } },
            'destroy': { method: 'DELETE', params: { id: '@id'} }
        });
}]);

todo_list.factory('Comments', ['$resource', function($resource) {
    return $resource('/comments', {},
        {
            'create': { method: 'POST', params: { task_list_id: '@task_list_id', name: '@name' } }
        });
}]);

todo_list.factory('Comment', ['$resource', function($resource) {
    return $resource('/comments/:id', {},
        {
            'update': { method: 'PATCH', params: { id: '@id', name: '@name' } },
            'destroy': { method: 'DELETE', params: { id: '@id' } }
        });
}]);

todo_list.factory('CheckLogin', ['Auth', '$location', function(Auth, $location) {
    return function() {
        if(!Auth.isAuthenticated()) {
            $location.path('/login');
        }
    }
}]);

