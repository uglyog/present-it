@PresentationController = ($scope, $http) ->
  $scope.presentation = new Presentation('localhost:8080',
    'http://localhost:9292/presentations/', '.haml', $http)
  $scope.presentation.initPresentation()