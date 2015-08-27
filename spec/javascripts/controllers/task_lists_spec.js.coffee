#= require spec_helper
describe 'ProjectsController', ->
  beforeEach ->
    @controller('ProjectsController', { $scope: @scope, $http: @http })
    @projects = { id: 1, name: 'first Project' }

    @http.whenGET('/projects').respond(200, @projects)
    @http.flush()

  describe 'add project', ->
    it 'update a project via api', ->
    @http.expectPATCH('/projects/1').respond({ 200, ''})
    @scope.updateProject('test', @projects.id)
    @http.flush()