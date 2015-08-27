#= require application
#= require angular-mocks
#= require sinonjs
#= require jasmine-sinon

beforeEach(module('todo_list'))

beforeEach inject (_$httpBackend_, _$compile_, $rootScope, $controller, $location, $injector, $timeout) ->
  @scope = $rootScope.$new()
  @http = _$httpBackend_
  @compile = _$compile_
  @location = $location
  @controller = $controller
  @injector = $injector
  @timeout = $timeout
  @model = (name) =>
    @injector.get(name)
  @eventLoop =
    flush: =>
      @scope.$digest()
  @sandbox = sinon.sandbox.create()

afterEach ->
  @http.resetExpectations()
  @http.verifyNoOutstandingExpectation()