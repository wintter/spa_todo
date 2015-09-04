controllers = angular.module('todo_list')

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